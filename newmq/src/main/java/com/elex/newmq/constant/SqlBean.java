package com.elex.newmq.constant;

public class SqlBean {

	//���ݿ��ı�ʶ��������ȥȡ��Ӧ�����ݿ�����
	public String tableFlag;
	//Ҫִ�е�sql���
	public String sql;
	
	public SqlBean(String tableFlag, String sql){
		this.tableFlag = tableFlag;
		this.sql = sql;
	}
	
}
