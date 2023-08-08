package com.elex.newmq.service;

import java.io.IOException;
import java.net.InetSocketAddress;

import org.apache.commons.configuration.HierarchicalConfiguration;
import org.apache.mina.filter.codec.ProtocolCodecFilter;
import org.apache.mina.transport.socket.nio.NioSocketAcceptor;

import com.elex.newmq.codec.MemcacheProtocolCodecFactory;
import com.elex.newmq.constant.MQConfig;
import com.elex.newmq.handler.MemcacheHandler;

/**
 * ����mina������tcp server�����������ڽ�����������mc����
 * @author qxc
 *
 */

public class RemotingServer implements IService{

	private NioSocketAcceptor acceptor;
	//�󶨵�ip��ַ
	private String bindAddr;
	//�����Ķ˿�
	private int port;
	private int processorNum;
	
	public void init(HierarchicalConfiguration configure) {
		//Ĭ�ϰ󶨵�ip��ַ
		this.bindAddr = configure.getString("bindaddr", MQConfig.DEFAULT_ADDR);
		//�������ļ��ж�ȡ�����Ķ˿�
		this.port = configure.getInt("bindport", MQConfig.DEFAULT_PORT);
		//�������ļ��ж�ȡ�������߳���Ŀ,Ĭ��Ϊcpu��Ŀ+2
		this.processorNum = configure.getInt("processornum", MQConfig.PROCESSOR_NUM);
		// Create an acceptor
    	acceptor = new NioSocketAcceptor(this.processorNum);
    	 // Create a protocolFilter
    	acceptor.getFilterChain().addLast("protocolFilter",
    			new ProtocolCodecFilter(new MemcacheProtocolCodecFactory()));
    	//set handler     	
        acceptor.setHandler(new MemcacheHandler());
	}

	public void start() throws IOException{
		acceptor.bind(new InetSocketAddress(bindAddr, port));
		System.out.println("Server now listening on port " + port);
	}

	public void stop() {
		// TODO Auto-generated method stub
		
	}

	public void reload() {
		// TODO Auto-generated method stub
		
	}

}
