package com.elex.newmq.share;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import com.elex.newmq.constant.DBServiceStatus;
import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.service.DataSourceManager;

/**
 * 定义一些程序公用变量
 * @author qxc
 *
 */
public class ShareVariable {
	//数据库服务的当前状态
	public static DBServiceStatus dbServiceStatus = DBServiceStatus.idle;
	//持久化文件指针当前的位置
	public static AtomicInteger curFileOffset = new AtomicInteger(0);
	public static DataSourceManager dataSource = null;//new DataSourceManager();
	public static ConcurrentHashMap<String, SqlBean> dataMap = new ConcurrentHashMap<String, SqlBean>();
	public static AtomicLong sumFileSize = new AtomicLong(0);
	public static long lastCommitTime = 0;
}
