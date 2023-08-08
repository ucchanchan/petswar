package com.elex.newmq.database;

import java.util.Enumeration;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.apache.commons.configuration.HierarchicalConfiguration;

import com.elex.newmq.constant.MQConfig;
import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.service.DBService;
import com.elex.newmq.share.ShareVariable;

public class PeriodCheckDataTask implements Runnable {

	private int initialDelay;
	private int duration;
	private int alurtSize;
	private int alurtTime;
	private ScheduledFuture Handler;
	private DBService dbService;
	
	public PeriodCheckDataTask(DBService dbService){
		this.dbService = dbService;
	}
	public void init(HierarchicalConfiguration configure){
		this.initialDelay = configure.getInt("checkInitialDelay", MQConfig.DEFAULT_CHECKDATA_INITIALDELAY);
		this.duration = configure.getInt("checkDuratioin", MQConfig.DEFAULT_CHECKDATA_DURATION);
		this.alurtSize = configure.getInt("checkAlurtSize", MQConfig.DEFAULT_CHECKDATA_ALURTSIZE);
		this.alurtTime = configure.getInt("checkAlurtTime", MQConfig.DEFAULT_CHECKDATA_ALURTTIME);
	}
	public void start(){
		this.Handler = Executors.newScheduledThreadPool(1).
		scheduleAtFixedRate(this, initialDelay, this.duration, TimeUnit.SECONDS);
	}
	public void run() {
		// TODO Auto-generated method stub
		long curTime = System.currentTimeMillis();
		if(ShareVariable.dataMap.size() > this.alurtSize || (curTime - ShareVariable.lastCommitTime > this.alurtTime
				&& ShareVariable.dataMap.size() > 0)){
			//÷¥––Ã·Ωª
			Enumeration<String> keys = ShareVariable.dataMap.keys();
			while(keys.hasMoreElements()){
				String curKey = keys.nextElement();
				this.dbService.add(ShareVariable.dataMap.get(curKey));
				ShareVariable.dataMap.remove(curKey);
			}
			ShareVariable.lastCommitTime = System.currentTimeMillis();
		}
	}

}
