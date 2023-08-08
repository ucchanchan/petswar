package com.elex.newmq;

import com.elex.newmq.constant.SqlBean;

import net.sf.json.JSONObject;

public class TestJson {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//²âÊÔ½âÎöjson×Ö·û´®
		String ori = "{\"key\":\"123456|user_account\",\"sql\":\"select * from user_account\"}";
		JSONObject jsonObject = JSONObject.fromObject( ori );  
		System.out.print(jsonObject.get("key"));
		
	}

}
