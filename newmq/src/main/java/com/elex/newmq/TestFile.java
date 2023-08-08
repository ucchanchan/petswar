package com.elex.newmq;

import java.io.File;
import java.io.IOException;

public class TestFile {

	/**
	 * @param args
	 * @throws IOException 
	 */
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		File file = new File("c:/");
		file.list();
		File file2 = file.getCanonicalFile();
		System.out.print(file2.getCanonicalPath());
	}

}
