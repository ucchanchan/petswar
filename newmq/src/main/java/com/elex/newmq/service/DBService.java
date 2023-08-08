package com.elex.newmq.service;

import java.util.concurrent.Executor;
import java.util.concurrent.Executors;

import org.apache.commons.configuration.HierarchicalConfiguration;

import com.elex.newmq.constant.MQConfig;
import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.database.DBProcessorPool;
import com.elex.newmq.database.PeriodCheckDataTask;
import com.elex.newmq.share.ShareVariable;
import com.elex.newmq.store.MessageStore;

/**
 * ���ݿ���񣬰�Լ�����Խ�hashmap�е������ύ�����ݿ���
 * @author qxc
 *
 */

public class DBService implements IService{
	
	private DBProcessorPool pool;
	private Executor executor;
	private int processorNum;
	private PeriodCheckDataTask task;
	
	public void init(HierarchicalConfiguration configure) {
		// TODO Auto-generated method stub
		//ShareVariable.dataSource.init(configure);
		this.processorNum = configure.getInt("processornum", MQConfig.DB_PROCESSOR_NUM);
		executor = Executors.newCachedThreadPool();
		this.pool = new DBProcessorPool(executor, this.processorNum);
		this.task = new PeriodCheckDataTask(this);
		this.task.init(configure);
	}

	public void add(SqlBean sql){
		this.pool.add(sql);
	}
	
	public void start() {
		// TODO Auto-generated method stub
		this.task.start();
	}

	public void stop() {
		// TODO Auto-generated method stub
		
	}

	public void reload() {
		// TODO Auto-generated method stub
		
	}

}
