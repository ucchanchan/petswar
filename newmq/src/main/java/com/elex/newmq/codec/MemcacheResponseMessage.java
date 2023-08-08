package com.elex.newmq.codec;

import com.elex.newmq.constant.MemcacheConstant;

public class MemcacheResponseMessage {

	//������Ϣ
	private String info;
	
	public MemcacheResponseMessage(String info){
		this.info = info;
		this.info += MemcacheConstant.END;
	}
	//���iobuffer������Դ
	public byte[] getBytes(){
		return this.info.getBytes();
	}
	//��ȡiobuffer��Ҫ����Ŀռ��С
	public int getSize(){
		return this.info.length();
	}
	public String getInfo(){
		return this.info;
	}
}
