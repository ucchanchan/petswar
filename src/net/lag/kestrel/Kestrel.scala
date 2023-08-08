/*
 * Copyright 2009 Twitter, Inc.
 * Copyright 2009 Robey Pointer <robeypointer@gmail.com>
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package net.lag.kestrel

import java.net.InetSocketAddress
import java.util.concurrent._
import java.util.concurrent.atomic.AtomicInteger
import scala.collection.{immutable, mutable}
import com.twitter.concurrent.NamedPoolThreadFactory
import com.twitter.conversions.time._
import com.twitter.logging.Logger
import com.twitter.naggati.codec.MemcacheCodec
import com.twitter.ostrich.admin.{PeriodicBackgroundProcess, RuntimeEnvironment, Service, ServiceTracker}
import com.twitter.ostrich.stats.Stats
import com.twitter.util.{Duration, Eval, Time, Timer => TTimer, TimerTask => TTimerTask}
import org.jboss.netty.bootstrap.ServerBootstrap
import org.jboss.netty.channel.{Channel, ChannelFactory, ChannelPipelineFactory, Channels}
import org.jboss.netty.channel.group.DefaultChannelGroup
import org.jboss.netty.channel.socket.nio.NioServerSocketChannelFactory
import org.jboss.netty.util.{HashedWheelTimer, Timeout, Timer, TimerTask}
import config._


// FIXME move me!
class NettyTimer(underlying: Timer) extends TTimer {
  def schedule(when: Time)(f: => Unit): TTimerTask = {
    val timeout = underlying.newTimeout(new TimerTask {
      def run(to: Timeout) {
        if (!to.isCancelled) f
      }
    }, (when - Time.now).inMilliseconds max 0, TimeUnit.MILLISECONDS)
    toTimerTask(timeout)
  }

  def schedule(when: Time, period: Duration)(f: => Unit): TTimerTask = {
    val task = schedule(when) {
      f
      schedule(when + period, period)(f)
    }
    task
  }

  def stop() { underlying.stop() }

  private[this] def toTimerTask(task: Timeout) = new TTimerTask {
    def cancel() { task.cancel() }
  }
}


class Kestrel(defaultQueueConfig: QueueConfig, builders: List[QueueBuilder],
              listenAddress: String, memcacheListenPort: Option[Int], textListenPort: Option[Int],
              queuePath: String, protocol: config.Protocol,
              expirationTimerFrequency: Option[Duration], clientTimeout: Option[Duration],
              maxOpenTransactions: Int)
      extends Service {
  private val log = Logger.get(getClass.getName)

  var queueCollection: QueueCollection = null
  var timer: Timer = null
  var journalSyncScheduler: ScheduledExecutorService = null
  var executor: ExecutorService = null
  var channelFactory: ChannelFactory = null
  var memcacheAcceptor: Option[Channel] = None
  var textAcceptor: Option[Channel] = None
  val channelGroup = new DefaultChannelGroup("channels")

  private def bytesRead(n: Int) {
    Stats.incr("bytes_read", n)
  }

  private def bytesWritten(n: Int) {
    Stats.incr("bytes_written", n)
  }

  def start() {
    log.info("Kestrel config: listenAddress=%s memcachePort=%s textPort=%s queuePath=%s " +
             "protocol=%s expirationTimerFrequency=%s clientTimeout=%s maxOpenTransactions=%d",
             listenAddress, memcacheListenPort, textListenPort, queuePath, protocol,
             expirationTimerFrequency, clientTimeout, maxOpenTransactions)

    // this means no timeout will be at better granularity than 100 ms.
    timer = new HashedWheelTimer(100, TimeUnit.MILLISECONDS)

    journalSyncScheduler =
      new ScheduledThreadPoolExecutor(
        Runtime.getRuntime.availableProcessors,
        new NamedPoolThreadFactory("journal-sync", true),
        new RejectedExecutionHandler {
          override def rejectedExecution(r: Runnable, executor: ThreadPoolExecutor) {
            log.warning("Rejected journal fsync")
          }
        })

    queueCollection = new QueueCollection(queuePath, new NettyTimer(timer), journalSyncScheduler, defaultQueueConfig, builders)
    queueCollection.loadQueues()

    Stats.addGauge("items") { queueCollection.currentItems.toDouble }
    Stats.addGauge("bytes") { queueCollection.currentBytes.toDouble }
    Stats.addGauge("reserved_memory_ratio") { queueCollection.reservedMemoryRatio }

    // netty setup:
    executor = Executors.newCachedThreadPool()
    channelFactory = new NioServerSocketChannelFactory(executor, executor)

    val memcachePipelineFactory = new ChannelPipelineFactory() {
      def getPipeline() = {
        val protocolCodec = protocol match {
          case Protocol.Ascii => MemcacheCodec.asciiCodec(bytesRead, bytesWritten)
          case Protocol.Binary => throw new Exception("Binary protocol not supported yet.")
        }
        val handler = new MemcacheHandler(channelGroup, queueCollection, maxOpenTransactions, clientTimeout)
        Channels.pipeline(protocolCodec, handler)
      }
    }
    memcacheAcceptor = memcacheListenPort.map { port =>
      val address = new InetSocketAddress(listenAddress, port)
      makeAcceptor(channelFactory, memcachePipelineFactory, address)
    }

    val textPipelineFactory = new ChannelPipelineFactory() {
      def getPipeline() = {
        val protocolCodec = TextCodec(bytesRead, bytesWritten)
        val handler = new TextHandler(channelGroup, queueCollection, maxOpenTransactions, clientTimeout)
        Channels.pipeline(protocolCodec, handler)
      }
    }
    textAcceptor = textListenPort.map { port =>
      val address = new InetSocketAddress(listenAddress, port)
      makeAcceptor(channelFactory, textPipelineFactory, address)
    }

    // optionally, start a periodic timer to clean out expired items.
    if (expirationTimerFrequency.isDefined) {
      log.info("Starting up background expiration task.")
      new PeriodicBackgroundProcess("background-expiration", expirationTimerFrequency.get) {
        def periodic() {
          val expired = Kestrel.this.queueCollection.flushAllExpired()
          if (expired > 0) {
            log.info("Expired %d item(s) from queues automatically.", expired)
          }
          // Now that we've cleaned out the queue, lets see if any of them are
          // ready to be expired.
          Kestrel.this.queueCollection.deleteExpiredQueues()
        }
      }.start()
    }
  }

  def shutdown() {
    log.info("Shutting down!")

    memcacheAcceptor.foreach { _.close().awaitUninterruptibly() }
    textAcceptor.foreach { _.close().awaitUninterruptibly() }

    if (queueCollection ne null) {
      queueCollection.shutdown()
      queueCollection = null
    }

    channelGroup.close().awaitUninterruptibly()
    if (channelFactory ne null) {
      channelFactory.releaseExternalResources()
      channelFactory = null
    }

    if (executor ne null) {
      executor.shutdown()
      executor.awaitTermination(5, TimeUnit.SECONDS)
      executor = null
    }
    if (timer ne null) {
      timer.stop()
      timer = null
    }
    if (journalSyncScheduler ne null) {
      journalSyncScheduler.shutdown()
      journalSyncScheduler.awaitTermination(5, TimeUnit.SECONDS)
      journalSyncScheduler = null
    }

    log.info("Goodbye.")
  }

  override def reload() {
    try {
      log.info("Reloading %s ...", Kestrel.runtime.configFile)
      new Eval().apply[KestrelConfig](Kestrel.runtime.configFile).reload(this)
    } catch {
      case e: Eval.CompilerException =>
        log.error(e, "Error in config: %s", e)
        log.error(e.messages.flatten.mkString("\n"))
    }
  }

  def reload(newDefaultQueueConfig: QueueConfig, newQueueBuilders: List[QueueBuilder]) {
    queueCollection.reload(newDefaultQueueConfig, newQueueBuilders)
  }

  private def makeAcceptor(channelFactory: ChannelFactory, pipelineFactory: ChannelPipelineFactory,
                           address: InetSocketAddress): Channel = {
    val bootstrap = new ServerBootstrap(channelFactory)
    bootstrap.setPipelineFactory(pipelineFactory)
    bootstrap.setOption("backlog", 1000)
    bootstrap.setOption("reuseAddress", true)
    bootstrap.setOption("child.keepAlive", true)
    bootstrap.setOption("child.tcpNoDelay", true)
    bootstrap.bind(address)
  }
}

object Kestrel {
  val log = Logger.get(getClass.getName)
  var kestrel: Kestrel = null
  var runtime: RuntimeEnvironment = null

  private val startTime = Time.now

  // track concurrent sessions
  val sessions = new AtomicInteger()
  val sessionId = new AtomicInteger()

  def main(args: Array[String]): Unit = {
    try {
      val default: QueueBuilder = new QueueBuilder
      var queues: List[QueueBuilder] = Nil
	
	  /**
	   * Address to listen for client connections. By default, accept from any interface.
	   */
	  var listenAddress: String = "0.0.0.0"
	
	  /**
	   * Port for accepting memcache protocol connections. 22133 is the standard port.
	   */
	  var memcacheListenPort: Option[Int] = Some(22133)
	
	  /**
	   * Port for accepting text protocol connections.
	   */
	  var textListenPort: Option[Int] = Some(2222)
	
	  /**
	   * Where queue journals should be stored. Each queue will have its own files in this folder.
	   */
	  var queuePath: String = "c:/tmp"
	
	  /**
	   * For future support. Only ascii is supported right now.
	   */
	  var protocol: Protocol = Protocol.Ascii
	
	  /**
	   * If you would like a timer to periodically sweep through queues and clean up expired items
	   * (when they are at the head of a queue), set the timer's frequency here. This is only useful
	   * for queues that are rarely (or never) polled, but may contain short-lived items.
	   */
	  var expirationTimerFrequency: Option[Duration] = None
	
	  /**
	   * An optional timeout for idle client connections. A client that hasn't sent a request in this
	   * period of time will be disconnected.
	   */
	  var clientTimeout: Option[Duration] = None
	
	  /**
	   * Maximum # of transactions (incomplete GETs) each client can have open at one time.
	   */
	  var maxOpenTransactions: Int = 100

      kestrel = new Kestrel(default(), queues, listenAddress, memcacheListenPort, textListenPort,
                queuePath, protocol, expirationTimerFrequency, clientTimeout,
                maxOpenTransactions)

      kestrel.start()
    } catch {
      case e =>
        log.error(e, "Exception during startup; exiting!")

        // Shut down all registered services such as AdminHttpService properly
        // so that SBT does not refuse to shut itself down when 'sbt run -f ...'
        // fails.
        ServiceTracker.shutdown()

        System.exit(1)
    }
    log.info("Kestrel %s started.", "2.1.5")
  }

  def uptime() = Time.now - startTime
}
