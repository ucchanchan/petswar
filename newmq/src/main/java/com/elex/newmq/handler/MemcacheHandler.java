package com.elex.newmq.handler;

import java.io.IOException;

import net.sf.json.JSONObject;

import org.apache.mina.core.service.IoHandlerAdapter;
import org.apache.mina.core.session.IoSession;

import com.elex.newmq.codec.MemcacheRequestMessage;
import com.elex.newmq.codec.MemcacheResponseMessage;
import com.elex.newmq.constant.MemcacheCommand;
import com.elex.newmq.constant.MemcacheConstant;
import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.service.PersistenceService;
import com.elex.newmq.share.ShareVariable;

public class MemcacheHandler extends IoHandlerAdapter {
	
	//接收到消息后的处理
	public void messageReceived(IoSession session, Object message) {
		MemcacheRequestMessage requestMsg = (MemcacheRequestMessage)message;
		MemcacheResponseMessage rep = null;
//		String re = "VALUE test 0 5\r\nhello\r\n";
//		MemcacheResponseMessage rep = new MemcacheResponseMessage(re);
//		session.write(rep);
		switch(requestMsg.getCommand()){
		case get:
			break;
		case set:
			//获取set的数据
			String key = requestMsg.getKey();
			String val = requestMsg.getValue();
			//首先要set到持久化文件中
			try {
				PersistenceService.instance().addItem(key+"~~"+val);
				setToMap(key, val);
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			rep = new MemcacheResponseMessage(MemcacheConstant.STORED);
			break;
		case stats:
			break;
		case add:
			break;
		case delete:
			break;
		}
		session.write(rep);
	}
	public void setToMap(String key, String val){
		//tableFlag标识要更新玩家的哪部分数据
		String tableFlag = key.split("\\|")[1];
		//对应要执行的sql语句
		String sql = val;
		ShareVariable.dataMap.put(key, new SqlBean(tableFlag, sql));
	}
}
