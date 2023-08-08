package com.elex.newmq.constant;

/**
 * 定义一些默认的常量
 * @author qxc
 *
 */
public class MQConfig {
	public static int DEFAULT_PORT					= 9999;
	public static String DEFAULT_ADDR				= "127.0.0.1";
	public static int PROCESSOR_NUM					= Runtime.getRuntime().availableProcessors() + 2;
	public static int DB_PROCESSOR_NUM				= Runtime.getRuntime().availableProcessors() + 2;
	public static String DEFAULT_CONFIG_PATH 		= "conf/newmq.xml";
	public static int MAX_DBCONN_SIZE				= 20;
	public static String DEFAULT_DATA_PATH = "./datalog/";
	public static String DEFAULT_DATA_PRE = "newmq";
	public static long DEFAULT_MAX_ONEFILE_SIZE = 1024;
	public static long DEFAULT_MAX_SUMFILE_SIZE = 4096;
	public static int DEFAULT_CHECKDATA_INITIALDELAY = 5;
	public static int DEFAULT_CHECKDATA_DURATION = 5;
	public static int DEFAULT_CHECKDATA_ALURTSIZE = 400000;
	public static int DEFAULT_CHECKDATA_ALURTTIME = 30;
}
