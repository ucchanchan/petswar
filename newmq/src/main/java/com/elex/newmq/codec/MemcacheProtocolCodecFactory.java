package com.elex.newmq.codec;

import org.apache.mina.filter.codec.demux.DemuxingProtocolCodecFactory;

public class MemcacheProtocolCodecFactory extends DemuxingProtocolCodecFactory{

	public MemcacheProtocolCodecFactory(){
		//������Ϣ������
		super.addMessageDecoder(MemcacheDecoder.class);
		//������Ϣ������
		super.addMessageEncoder(MemcacheResponseMessage.class, MemcacheEncoder.class);
	}
}
