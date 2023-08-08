package com.elex.newmq.share;

import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicLong;

import com.elex.newmq.constant.DBServiceStatus;
import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.service.DataSourceManager;

/**
 * ����һЩ�����ñ���
 * @author qxc
 *
 */
public class ShareVariable {
	//���ݿ����ĵ�ǰ״̬
	public static DBServiceStatus dbServiceStatus = DBServiceStatus.idle;
	//�־û��ļ�ָ�뵱ǰ��λ��
	public static AtomicInteger curFileOffset = new AtomicInteger(0);
	public static DataSourceManager dataSource = null;//new DataSourceManager();
	public static ConcurrentHashMap<String, SqlBean> dataMap = new ConcurrentHashMap<String, SqlBean>();
	public static AtomicLong sumFileSize = new AtomicLong(0);
	public static long lastCommitTime = 0;
}
