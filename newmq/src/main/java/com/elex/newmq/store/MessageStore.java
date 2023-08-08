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
		//����curFileOffset
	    ShareVariable.curFileOffset.getAndAdd(4 + value.length());
	    ShareVariable.sumFileSize.getAndAdd(4 + value.length());
		return true;
	}
	
	public FileChannel getWriter(){
		return this.writer;
	}
	/**
	 * �ӳ־û��ļ��лָ�����
	 * @return
	 * @throws IOException 
	 */
	public void replay() throws IOException{
		//������ǰ�ļ�ֱ���ļ�ĩ
		while(this.reader.position() < this.reader.size()){
				String curString = this.readItem();
				String[] tmp = curString.split("~~");
				String key = tmp[0];
				String sql = tmp[1];
				//tableFlag��ʶҪ������ҵ��Ĳ�������
				String tableFlag = key.split("\\|")[1];
				//��ӦҪִ�е�sql���
				//String sql = (String) jsonObject.get("sql");
				ShareVariable.dataMap.put(key, new SqlBean(tableFlag, sql));
		}
	}
	/**
	 * �ӳ־û��ļ���ȡ����������
	 * @param in �ļ���Ӧ��filechannel
	 * @return ����json��ʽ���ַ���
	 * @throws IOException
	 */
	public String readItem() throws IOException{
		//���Ȼ�ȡ���ݶεĳ��ȣ����ݳ���ȥȡ�ö�Ӧ���ݡ�
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
	    //�������ݳ���ȥȡ�ö�Ӧ�����ݶ�
	    byte[] data = new byte[dataLength];
	    ByteBuffer dataBuffer = ByteBuffer.wrap(data);
	    x = 0;
	    do{
	    	x = this.reader.read(dataBuffer);
	    }while(dataBuffer.position() < dataBuffer.limit() && x >=0);
	    //����curFileOffset
	    ShareVariable.curFileOffset.getAndAdd(4 + dataLength);
	    dataBuffer.flip();
	    CharBuffer charReader = Charset.forName("UTF-8").decode(dataBuffer);
		return charReader.toString();
	}
	//�������е������ύ��Ӳ����
	public void fsync() throws IOException{
		this.writer.force(false);
	}
	//�Ƿ�����fsync������
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
