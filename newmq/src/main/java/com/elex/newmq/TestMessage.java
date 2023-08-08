package com.elex.newmq;

import java.io.File;
import java.io.IOException;

import com.elex.newmq.service.PersistenceService;
import com.elex.newmq.store.MessageStore;

public class TestMessage {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
//		PersistenceService service = new PersistenceService();
//		service.init();
//		service.start();
//		try {
//			//service.addItem("hellow orld");
//		} catch (IOException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		}
		MessageStore store = new MessageStore();
		File file = new File("datalogs/test.12345");
		//System.out.print(file.getAbsolutePath());
		store.init(file);
		for(int i=0;i<5;i++){
			store.addValue("hello world"+i);
		}
		String re = store.readItem();
		//store.replay();
	}

}
