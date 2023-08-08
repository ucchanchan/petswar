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

import scala.collection.mutable
import com.twitter.conversions.time._
import com.twitter.logging.Logger
import com.twitter.naggati.ProtocolError
import com.twitter.naggati.codec.{MemcacheRequest, MemcacheResponse}
import com.twitter.ostrich.stats.Stats
import com.twitter.util.{Duration, Time}
import org.jboss.netty.channel.Channel
import org.jboss.netty.channel.group.ChannelGroup

/**
 * Memcache protocol handler for a kestrel connection.
 */
class MemcacheHandler(
  channelGroup: ChannelGroup,
  queueCollection: QueueCollection,
  maxOpenTransactions: Int,
  clientTimeout: Option[Duration])
extends NettyHandler[MemcacheRequest](channelGroup, queueCollection, maxOpenTransactions, clientTimeout) {
  protected final def handle(request: MemcacheRequest) = {
    request.line(0) match {
      case "get" =>
        get(request.line(1))
      case "monitor" =>
        monitor(request.line(1), request.line(2).toInt)
      case "confirm" =>
        if (closeTransactions(request.line(1), request.line(2).toInt)) {
          channel.write(new MemcacheResponse("END"))
        } else {
          channel.write(new MemcacheResponse("ERROR"))
        }
      case "set" =>
        val now = Time.now
        val expiry = request.line(3).toInt
        val normalizedExpiry: Option[Time] = if (expiry == 0) {
          None
        } else if (expiry < 1000000) {
          Some(now + expiry.seconds)
        } else {
          Some(Time.epoch + expiry.seconds)
        }
        try {
          if (setItem(request.line(1), request.line(2).toInt, normalizedExpiry, request.data.get)) {
            channel.write(new MemcacheResponse("STORED"))
          } else {
            channel.write(new MemcacheResponse("NOT_STORED"))
          }
        } catch {
          case e: NumberFormatException =>
            throw new ProtocolError("bad request: " + request)
        }
      case "stats" =>
        stats()
      case "shutdown" =>
        shutdown()
      case "reload" =>
        Kestrel.kestrel.reload()
        channel.write(new MemcacheResponse("Reloaded config."))
      case "flush" =>
        flush(request.line(1))
        channel.write(new MemcacheResponse("END"))
      case "flush_all" =>
        flushAllQueues()
        channel.write(new MemcacheResponse("Flushed all queues."))
      case "dump_stats" =>
        dumpStats(request.line.drop(1))
      case "delete" =>
        delete(request.line(1))
        channel.write(new MemcacheResponse("DELETED"))
      case "flush_expired" =>
        channel.write(new MemcacheResponse(flushExpired(request.line(1)).toString))
      case "flush_all_expired" =>
        val flushed = queues.flushAllExpired()
        channel.write(new MemcacheResponse(flushed.toString))
      case "version" =>
        version()
      case "quit" =>
        quit()
      case x =>
        channel.write(new MemcacheResponse("CLIENT_ERROR"))
    }
  }

  protected final def handleProtocolError() {
    channel.write(new MemcacheResponse("CLIENT_ERROR"))
  }

  protected final def handleException(e: Throwable) {
    channel.write(new MemcacheResponse("ERROR"))
  }

  private def get(name: String): Unit = {
    var key = name
    var timeout: Option[Time] = None
    var closing = false
    var opening = false
    var aborting = false
    var peeking = false
    var closeAll = false

    if (name contains '/') {
      val options = name.split("/")
      key = options(0)
      for (i <- 1 until options.length) {
        val opt = options(i)
        if (opt startsWith "t=") {
          timeout = Some(opt.substring(2).toInt.milliseconds.fromNow)
        }
        if (opt == "close") closing = true
        if (opt == "open") opening = true
        if (opt == "abort") aborting = true
        if (opt == "peek") peeking = true
        if (opt == "closeall") closeAll = true
      }
    }

    if ((key.length == 0) || ((peeking || aborting) && (opening || closing)) || (peeking && aborting)) {
      channel.write(new MemcacheResponse("CLIENT_ERROR"))
      channel.close()
      return
    }

    if (aborting) {
      abortTransaction(key)
      channel.write(new MemcacheResponse("END"))
    } else if(closeAll){
      closeAllTransactions(key)
      channel.write(new MemcacheResponse("END"))
    }else {
      if (closing) {
        closeTransaction(key)
        if (!opening) channel.write(new MemcacheResponse("END"))
      }
      if (opening || !closing) {
        if (pendingTransactions.size(key) > 0 && !peeking && !opening) {
          log.warning("Attempt to perform a non-transactional fetch with an open transaction on " +
                      " '%s' (sid %d, %s)", key, sessionId, clientDescription)
          channel.write(new MemcacheResponse("ERROR"))
          channel.close()
          return
        }
        try {
          getItem(key, timeout, opening, peeking).map { itemOption =>
            itemOption match {
              case None =>
                channel.write(new MemcacheResponse("END"))
              case Some(item) =>
                channel.write(new MemcacheResponse("VALUE %s 0 %d".format(key, item.data.length), item.data))
            }
          }
        } catch {
          case e: TooManyOpenTransactionsException =>
            channel.write(new MemcacheResponse("ERROR"))
            channel.close()
            return
        }
      }
    }
  }

  private def monitor(key: String, timeout: Int) {
    monitorUntil(key, Time.now + timeout.seconds) {
      case None =>
        channel.write(new MemcacheResponse("END"))
      case Some(item) =>
        channel.write(new MemcacheResponse("VALUE %s 0 %d".format(key, item.data.length), item.data))
    }
  }

  private def stats() = {
    var report = new mutable.ArrayBuffer[(String, String)]
    report += (("uptime", Kestrel.uptime.inSeconds.toString))
    report += (("time", (Time.now.inMilliseconds / 1000).toString))
    report += (("version", Kestrel.runtime.jarVersion))
    report += (("curr_items", queues.currentItems.toString))
    report += (("total_items", Stats.getCounter("total_items")().toString))
    report += (("bytes", queues.currentBytes.toString))
    report += (("reserved_memory_ratio", "%.3f".format(queues.reservedMemoryRatio)))
    report += (("curr_connections", Kestrel.sessions.get().toString))
    report += (("total_connections", Stats.getCounter("total_connections")().toString))
    report += (("cmd_get", Stats.getCounter("cmd_get")().toString))
    report += (("cmd_set", Stats.getCounter("cmd_set")().toString))
    report += (("cmd_peek", Stats.getCounter("cmd_peek")().toString))
    report += (("get_hits", Stats.getCounter("get_hits")().toString))
    report += (("get_misses", Stats.getCounter("get_misses")().toString))
    report += (("bytes_read", Stats.getCounter("bytes_read")().toString))
    report += (("bytes_written", Stats.getCounter("bytes_written")().toString))
    report += (("queue_creates", Stats.getCounter("queue_creates")().toString))
    report += (("queue_deletes", Stats.getCounter("queue_deletes")().toString))
    report += (("queue_expires", Stats.getCounter("queue_expires")().toString))

    for (qName <- queues.queueNames) {
      report ++= queues.stats(qName).map { case (k, v) => ("queue_" + qName + "_" + k, v) }
    }

    val summary = {
      for ((key, value) <- report) yield "STAT %s %s".format(key, value)
    }.mkString("", "\r\n", "\r\nEND")
    channel.write(new MemcacheResponse(summary))
  }

  private def dumpStats(requestedQueueNames : List[String]) = {
    val queueNames = if (!requestedQueueNames.isEmpty) { requestedQueueNames } else { queues.queueNames }
    val dump = new mutable.ListBuffer[String]
    for (qName <- queueNames) {
      dump += "queue '" + qName + "' {"
      dump += queues.stats(qName).map { case (k, v) => k + "=" + v }.mkString("  ", "\r\n  ", "")
      dump += "}"
    }
    channel.write(new MemcacheResponse(dump.mkString("", "\r\n", "\r\nEND")))
  }

  private def version() = {
    channel.write(new MemcacheResponse("VERSION " + Kestrel.runtime.jarVersion))
  }

  private def quit() = {
    channel.close()
  }
}
