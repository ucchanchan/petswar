package com.elex.newmq.codec;

import java.nio.charset.CharacterCodingException;
import java.nio.charset.Charset;
import java.nio.charset.CharsetDecoder;

import org.apache.mina.core.buffer.IoBuffer;
import org.apache.mina.core.session.IoSession;
import org.apache.mina.filter.codec.ProtocolDecoderOutput;
import org.apache.mina.filter.codec.demux.MessageDecoderAdapter;
import org.apache.mina.filter.codec.demux.MessageDecoderResult;

import com.elex.newmq.constant.MemcacheCommand;

public class MemcacheDecoder extends MessageDecoderAdapter {

	private CharsetDecoder decoder = Charset.defaultCharset().newDecoder();
	
	public MessageDecoderResult decodable(IoSession session, IoBuffer in) {
		// TODO Auto-generated method stub
		return MessageDecoderResult.OK;
	}

	public MessageDecoderResult decode(IoSession session, IoBuffer in,
			ProtocolDecoderOutput out) throws Exception {
		// TODO Auto-generated method stub
		//String command = this.getCommand(in);
		String command = this.getString(in);
		MemcacheRequestMessage requestMsg = new MemcacheRequestMessage();
		switch(MemcacheCommand.getCommand(command)){
			case get:
				this.decodeGet(in, requestMsg);
				break;
			case set:
				this.decodeSet(in, requestMsg);
				break;
			case delete:
				this.decodeDelete(in, requestMsg);
				break;
		}
		//MemcacheRequestMessage requestMsg = new MemcacheRequestMessage(in.getString(this.decoder));	
		out.write(requestMsg);
		return MessageDecoderResult.OK;
	}
	//解析get
	private MemcacheRequestMessage decodeGet(IoBuffer in, MemcacheRequestMessage reqMsg) throws CharacterCodingException{
		reqMsg.setCommand(MemcacheCommand.get);
		String key = this.getString(in);
		reqMsg.setKey(key);
		return reqMsg;
	}
	//解析set
	private MemcacheRequestMessage decodeSet(IoBuffer in, MemcacheRequestMessage reqMsg) throws CharacterCodingException{
		reqMsg.setCommand(MemcacheCommand.set);
		String key = this.getString(in);
		reqMsg.setKey(key);
		int flags = Integer.parseInt(this.getString(in));
		int expiretime = Integer.parseInt(this.getString(in));
		int length = Integer.parseInt(this.getString(in));
 		String value = this.getStringByLength(in, length);
 		reqMsg.setValue(value);
		return reqMsg;
	}
	//解析delete
	private MemcacheRequestMessage decodeDelete(IoBuffer in, MemcacheRequestMessage reqMsg) throws CharacterCodingException{
		reqMsg.setCommand(MemcacheCommand.delete);
		String key = this.getString(in);
		reqMsg.setKey(key);
		return reqMsg;
	}
	//根据长度来读取字符串
	private String getStringByLength(IoBuffer in, int length) throws CharacterCodingException{
		in.limit(in.position() + length);
		String tmpStr = in.getString(this.decoder);
		return tmpStr;
		//return null;
	}
	//读取一个字符串
	private String getString(IoBuffer in) throws CharacterCodingException{
		PositionBean pb = this.getNextPosition(in);
		in.position(pb.oldPosition);
		in.limit(pb.curPosition);
		String tmpStr = in.getString(this.decoder);
		in.limit(in.capacity());
		in.position(pb.nextPosition);
		return tmpStr;
	}
	private int getInt(IoBuffer in){
		PositionBean pb = this.getNextPosition(in);
		in.position(pb.oldPosition);
		in.limit(pb.curPosition);
		int tmpInt = in.getInt();
		in.limit(in.capacity());
		in.position(pb.nextPosition);
		return tmpInt;
	}
	/**
	 * 取得bytebuffer下一个起始读取的位置，以空格或\r\n为标志
	 * @param in
	 * @return
	 */
	private PositionBean getNextPosition(IoBuffer in){
		PositionBean pb = new PositionBean();
		pb.oldPosition = in.position();
		while(in.hasRemaining()){
			byte b = in.get();
			if(b == ' '){
				pb.curPosition = in.position() -1;
				pb.nextPosition = in.position();
				break;
			}else if(b == '\r'){
				in.get();
				pb.curPosition = in.position() -2;
				pb.nextPosition = in.position();
				break;
			}
		}
		return pb;
	}
	
	private class PositionBean{
		public int oldPosition = 0;
		public int curPosition = 0;
		public int nextPosition = 0;
	}
}
