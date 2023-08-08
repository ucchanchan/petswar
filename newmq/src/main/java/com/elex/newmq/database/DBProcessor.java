package com.elex.newmq.database;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Queue;
import java.util.concurrent.ConcurrentLinkedQueue;
import java.util.concurrent.Executor;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.concurrent.atomic.AtomicReference;

import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.share.ShareVariable;

/**
 * ���ݿ��ύ����
 * @author qxc
 *
 */

public class DBProcessor {
	//���̳�ִ����
	private final Executor executor;
	private final AtomicReference<Processor> processorRef = new AtomicReference<Processor>();
	//sql����
	private final Queue<SqlBean> newSqls = new ConcurrentLinkedQueue<SqlBean>();
	//��ǰ��Ҫִ�е�sql����
	private final AtomicInteger sqlNums = new AtomicInteger(0); 
	
	private Connection conn = null;
	private Statement stmt = null;
	private ResultSet rset = null;
	
	public DBProcessor(Executor e){
		this.executor = e;
	}

	/**
	 * �����ý��̣����processorδ��ʼ�������ʼ��֮
	 */
	private void startupProcessor() {
        Processor processor = processorRef.get();
        
        if (processor == null) {
            processor = new Processor();
            if (processorRef.compareAndSet(null, processor)) {
                executor.execute(processor);
            }
        }else{
        	 //���Ѹý���
            processor.wakeUp();
        }
    }
	/**
	 * Ϊ��ǰ��������һ���µ�sql
	 * @param newsql
	 */
	public final void add(SqlBean newsql){
		this.newSqls.add(newsql);
		this.sqlNums.getAndIncrement();
		this.startupProcessor();
	}
	/**
	 * ��ȡ��ǰ����ִ�ж����е�sql����
	 * @return int sqlnum
	 */
	public int getCurrentSqlNums(){
		return this.sqlNums.get();
	}
	/**
	 * �жϵ�ǰ�����Ƿ�ִ�����
	 * @return
	 */
	public Boolean checkHasComplete(){
		return this.sqlNums.get() == 0 ? true : false;
	}
	
	/**
	 * sqlִ����
	 * @author qxc
	 */
	private class Processor implements Runnable {
		private boolean waiting = false;
		public void run() {
			assert (processorRef.get() == this);
			SqlBean newsql;
			while(true){
				while((newsql = newSqls.poll()) != null){
					//SqlBean newsql = newSqls.poll();
					try {
						conn = ShareVariable.dataSource.getConnection(newsql.tableFlag);
						stmt = conn.createStatement();
				        rset = stmt.executeQuery(newsql.sql);
				        int cols = rset.getMetaData().getColumnCount();				 
				        while(rset.next()) {
				            for(int i=1;i<=cols;i++) {
				                System.out.print(rset.getString(i));
				                System.out.print("|");
				            }
				            System.out.println("");
				        }
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}	
				}
				try {
					synchronized(this){
						this.waiting = true;
						this.wait();
					}
				} catch (InterruptedException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		public void wakeUp(){
			if(this.waiting){
				synchronized(this){
					this.waiting = false;
					this.notify();
				}
			}
		}
	}

}
