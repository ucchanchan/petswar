package com.elex.newmq.database;

import java.util.concurrent.Executor;

import com.elex.newmq.constant.SqlBean;

/**
 * ���ݿ��ύ���̳أ�����mina��ʵ��
 * @author qxc
 *
 */

public class DBProcessorPool {
	private final Executor executor;
	//Ĭ�������Ľ�����Ŀ
	private static final int DEFAULT_SIZE = Runtime.getRuntime().availableProcessors() + 1;
	//���̳�
	private final DBProcessor[] pool;
	
	//��ʼ�����̳صĽ�����������������ļ�û�����ã���ʹ��Ĭ��ֵ
	public DBProcessorPool(Executor e){
		this(e, DEFAULT_SIZE);
	}
	/**
	 * ��ʼ�����̳�
	 * @param e ����ִ����
	 * @param size �������ύ���̵�����
	 */
	public DBProcessorPool(Executor e, int size){
		this.executor = e;
		this.pool = new DBProcessor[size];
		for(int i=0; i<pool.length; i++){
			try{
				pool[i] = new DBProcessor(this.executor);
			}catch(Exception ex){}
		}
	}
	/**
	 * ���Ϊsqlִ�з���һ������
	 */
	private DBProcessor getRandomProcessor(){
		int randomIndex = (int)(Math.random()*(this.pool.length));
		return this.pool[randomIndex];
	}
	/**
	 * �����µ�sql���
	 * @param sql Ҫִ�е�sql��
	 */
	public final void add(SqlBean sql){
		DBProcessor processor = this.getRandomProcessor();
		processor.add(sql);
	}
	/**
	 * �鿴���̳��еĽ����Ƿ�ִ�����
	 * @return
	 */
	public Boolean checkHasComplete(){
		Boolean re = true;
		for(int i=0;i<pool.length; i++){
			if(!pool[i].checkHasComplete()){
				re = false;
				break;
			}
		}
		return re;
	}
}
