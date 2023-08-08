package com.elex.newmq.service;

import java.io.File;
import java.io.FileFilter;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.channels.FileLock;
import java.util.Arrays;
import java.util.Comparator;

import org.apache.commons.configuration.HierarchicalConfiguration;

import com.elex.newmq.constant.MQConfig;
import com.elex.newmq.share.ShareVariable;
import com.elex.newmq.store.MessageStore;
import com.elex.newmq.store.PeriodicSyncTask;

/**
 * 持久化服务
 * @author qxc
 *
 */

public class PersistenceService implements IService {

	private MessageStore messageStore;
	private PeriodicSyncTask fsyncTask;
	private String dataPath;
	private String dataPre;
	private File dirPath;
	private long maxOneFileSize;
	private long maxSumFileSize;
	private static PersistenceService _instance;
	
	public PersistenceService(){
	}
	/**
	 * 添加一个item到持久化文件中
	 * 这里需要做文件的拆分。
	 * @param value
	 * @throws IOException
	 */
	public synchronized void addItem(String value) throws IOException{
		this.checkRotate();
		this.messageStore.addValue(value);
	}
	public static PersistenceService instance(){
		return PersistenceService._instance;
	}
	public void init(HierarchicalConfiguration configure) throws IOException {
		this._instance = this;
		this.dataPath = configure.getString("datapath", MQConfig.DEFAULT_DATA_PATH);
		this.dataPre = configure.getString("datapre", MQConfig.DEFAULT_DATA_PRE);
		this.maxOneFileSize = configure.getLong("maxonefilesize", MQConfig.DEFAULT_MAX_ONEFILE_SIZE);
		this.maxSumFileSize = configure.getLong("maxsumfilesize", MQConfig.DEFAULT_MAX_SUMFILE_SIZE);
		this.dirPath = new File(this.dataPath);
		this.messageStore = new MessageStore();
		this.replay();
		this.fsyncTask = new PeriodicSyncTask(5,5,this.messageStore);
	}

	public void start() {
		this.fsyncTask.start();
	}
	/**
	 * 检查是否需要生成一个新的数据文件
	 * @throws IOException 
	 */
	private void checkRotate() throws IOException{
		if( ShareVariable.curFileOffset.get()  > this.maxOneFileSize){
			//获取独占锁
			//FileLock lock = this.messageStore.lock();
			this.messageStore.close();
			File newFile = this.uniqueFile();
			this.messageStore.init(newFile);
			//ShareVariable.sumFileSize.set(this.caculateSumFileSize());
			//lock.release();
		}
		if(ShareVariable.sumFileSize.get() > this.maxSumFileSize){
			//TODO 则删除最旧的那一个文件，需要避免删除包含未提交数据的文件
			File[] lsFiles = this.getFileList();
			if(lsFiles.length > 1){
				boolean re = lsFiles[0].delete();
				//ShareVariable.sumFileSize.set(this.caculateSumFileSize());
			}
		}
		return;
	}
	private long caculateSumFileSize(){
		File[] lsFiles = this.dirPath.listFiles();
		long size = 0;
		for(int i=0; i < lsFiles.length; i++){
			if(lsFiles[i].isFile())
				size += lsFiles[i].length();
		}
		return size;
	}
	private void retate(){
		
	}
	/**
	 * 获取一个新的数据文件句柄
	 * @return  FILE
	 * @throws IOException
	 */
	private File uniqueFile() throws IOException{
		String path = this.dataPre + "." + System.currentTimeMillis();
		File f = new File(this.dataPath, path);
		f.createNewFile();
		return f;
	}
	public void stop() throws IOException {

		this.fsyncTask.stop();
	}

	public void reload() {
		// TODO Auto-generated method stub

	}
	private File[] getFileList() throws IOException{
		//过滤不合法的文件
		//String[] allFiles = this.dirPath.list();
		//for(int i=0;i<allFiles.length;i++){
			//以dataPre+"~~"开头的需要删除，说明是一个中间文件
		//	if(allFiles[i].startsWith(this.dataPre+"~~") || 
		//		allFiles[i].split(".").length != 2){
		//		new File(this.dataPath + allFiles[i]).delete();
		//	}
		//}
		//ShareVariable.sumFileSize.set(this.caculateSumFileSize());
		//if(ShareVariable.sumFileSize.get() == 0){
			//说明没有任何可恢复的文件
		//	this.uniqueFile();
		//}
		ShareVariable.sumFileSize.set(0);
		File[] lsFiles = this.dirPath.listFiles(new FileFilter(){
			public boolean accept(File arg0) {
				if(arg0.isFile()){
					if(arg0.getName().split("\\.").length != 2){
						arg0.delete();
						return false;
					}else{
						ShareVariable.sumFileSize.getAndAdd(arg0.length());
						return true;
					}
				}
				else
					return false;
			}
		});
		if(lsFiles.length == 0){
			lsFiles = new File[1];
			lsFiles[0] = this.uniqueFile();
		}
		//对剩下的文件按生成时间进行排序，旧的在前
		Arrays.sort(lsFiles,  new   Comparator <File> (){
		      public   int   compare(File   file1,   File   file2)   {
		          String name1 = file1.getName();
		          String name2 = file2.getName();
		          long lmt1 = Long.parseLong(name1.split("\\.")[1]);
		          long lmt2 = Long.parseLong(name2.split("\\.")[1]);
		          return (int)(lmt1 - lmt2);
		      } 
		    }      
		);
		return lsFiles;
	}
	/**
	 * 从持久化文件中恢复数据
	 * @throws IOException 
	 */
	private void replay() throws IOException{
		File[] lsFiles = this.getFileList();
		//恢复顺序从旧到新进行恢复，所以应该旧文件排在前
		for(int i=0; i < lsFiles.length ; i++){
			this.replayFile(lsFiles[i]);
		}
		//初始化writer position的位置。
		this.messageStore.setCurWriterPos();
		return;
	}
	/**
	 * 恢复单个数据文件
	 * @throws IOException 
	 */
	private void replayFile(File file) throws IOException{
		this.messageStore.init(file);
		this.messageStore.replay();
		return;
	}
}
