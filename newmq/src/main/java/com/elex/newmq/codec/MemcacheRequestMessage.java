package com.elex.newmq.codec;

import com.elex.newmq.constant.MemcacheCommand;
import com.elex.newmq.constant.MemcacheConstant;

public class MemcacheRequestMessage {
	
	//data
	private String[] lines;
	private MemcacheCommand command = null;
	private String key = null;
	private String value = null;
	
	public MemcacheRequestMessage(){
		
	}
	
	public MemcacheRequestMessage(String data){
		//¹ýÂËµô\r\n
		String temp = data.substring(0, data.length()-2);
		//data
		this.lines = temp.split(" |" + MemcacheConstant.SEP);
	}
	
	public MemcacheCommand getCommand(){
		return this.command;
	}
	public void setCommand(MemcacheCommand command){
		this.command = command;
	}
	public String getKey(){
		return this.key;
	}
	public void setKey(String key){
		this.key = key;
	}
	
	public String getValue(){
		return this.value;
	}
	public void setValue(String value){
		this.value = value;
	}
	public String[] getlines(){
		return this.lines;
	}

}
