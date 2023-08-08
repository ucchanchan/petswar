package com.elex.newmq.store;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.channels.FileChannel;
import java.nio.channels.FileLock;
import java.nio.charset.Charset;
import java.nio.CharBuffer;

import net.sf.json.JSONObject;

import com.elex.newmq.constant.SqlBean;
import com.elex.newmq.share.ShareVariable;

public class MessageStore {
	
	private FileChannel writer = null;
	private FileChannel reader = null;
	private File file;
	private byte[] buffer = new byte[4];
	private ByteBuffer byteBuffer = ByteBuffer.wrap(buffer);
	private Boolean _canSync = false;
	
	public void init(File file) throws IOException{
		if(this.writer != null)
			this.writer.close();
		if(this.reader != null)
			this.reader.close();
		this.file = file;
		this.writer = (new FileOutputStream(this.file, true)).getChannel();
		this.reader = new FileInputStream(this.file).getChannel();
		this._canSync = true;
		ShareVariable.curFileOffset.getAndSet(0);
	}
	public FileLock lock() throws IOException{
		return this.writer.lock();
	}
	public Boolean addValue(String value) throws IOException{
		ByteBuffer buffer = ByteBuffer.allocate(value.length() + 4);
		//buffer.order(ByteOrder.LITTLE_ENDIAN);
		buffer.putInt(value.length());
		buffer.put(value.getBytes());
		buffer.flip();
		int re = writer.write(buffer);
		if(re <= 0)
			throw new IOException("write error");
		//重置curFileOffset
	    ShareVariable.curFileOffset.getAndAdd(4 + value.length());
	    ShareVariable.sumFileSize.getAndAdd(4 + value.length());
		return true;
	}
	
	public FileChannel getWriter(){
		return this.writer;
	}
	/**
	 * 从持久化文件中恢复数据
	 * @return
	 * @throws IOException 
	 */
	public void replay() throws IOException{
		//遍历当前文件直至文件末
		while(this.reader.position() < this.reader.size()){
				String curString = this.readItem();
				String[] tmp = curString.split("~~");
				String key = tmp[0];
				String sql = tmp[1];
				//tableFlag标识要更新玩家的哪部分数据
				String tableFlag = key.split("\\|")[1];
				//对应要执行的sql语句
				//String sql = (String) jsonObject.get("sql");
				ShareVariable.dataMap.put(key, new SqlBean(tableFlag, sql));
		}
	}
	/**
	 * 从持久化文件中取出单条数据
	 * @param in 文件对应的filechannel
	 * @return 返回json格式的字符串
	 * @throws IOException
	 */
	public String readItem() throws IOException{
		//首先获取数据段的长度，根据长度去取得对应数据。
	    byteBuffer.limit(4);
	    byteBuffer.rewind();
	    int x = 0;
	    do{
	    	x = this.reader.read(byteBuffer);
	    }while(byteBuffer.position() < byteBuffer.limit() && x >=0);
	    if( x < 0 ){
	    	throw new IOException("Unexpected EOF");
	    }
	    byteBuffer.rewind();
	    int dataLength = byteBuffer.getInt();
	    //根据数据长度去取得对应的数据段
	    byte[] data = new byte[dataLength];
	    ByteBuffer dataBuffer = ByteBuffer.wrap(data);
	    x = 0;
	    do{
	    	x = this.reader.read(dataBuffer);
	    }while(dataBuffer.position() < dataBuffer.limit() && x >=0);
	    //重置curFileOffset
	    ShareVariable.curFileOffset.getAndAdd(4 + dataLength);
	    dataBuffer.flip();
	    CharBuffer charReader = Charset.forName("UTF-8").decode(dataBuffer);
		return charReader.toString();
	}
	//将缓存中的数据提交到硬盘中
	public void fsync() throws IOException{
		this.writer.force(false);
	}
	//是否满足fsync的条件
	public Boolean canFsync(){
		return true;
	}
	public void setCurWriterPos() throws IOException{
		this.writer.position(this.reader.position());
	}
	public void close() throws IOException{
		this.fsync();
		this._canSync = false;
		//this.writer.close();
	}
}
