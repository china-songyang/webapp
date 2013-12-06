package com.saturn.app.utils;

import org.apache.log4j.Logger;

/**
 * Log4J基类
 * 
 * @author 谷钰
 * 
 * @version 1.0 2011.04.26
 *
 */
public class LogManager {
	public static String LOG_KEY_APP = "app";
	
	public static String LOG_KEY_AUTH = "auth";
	
	private LogManager() {
	}
	
	public static Logger getLogger(String key) {
		if (key != null) {
			return Logger.getLogger(key);
		}
		
		return Logger.getRootLogger();
	}
}
