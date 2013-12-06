package com.saturn.app.utils;

import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;

import org.dom4j.Document;
import org.dom4j.io.SAXReader;

/**
 * Dom4j简化工具类,根据InputStream获得Document对象
 * 
 * @author 谷钰
 * 
 * @version 1.0 2008.8.28
 * 
 */
public abstract class Dom4jUtils {

	/**
	 * 把输入字节流转换成可读取的xml对象
	 * 
	 * @param in
	 *            输入字节流
	 * @return
	 */
	public static Document getDocment(InputStream in) {

		SAXReader reader = new SAXReader();
		Document document = null;

		try {
			document = reader.read(in);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				in.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return document;
	}

	/**
	 * 把输入字符流换成可读取的xml对象
	 * 
	 * @param reader
	 *            输入字符流
	 * @return
	 */
	public static Document getDocment(Reader reader) {
		SAXReader saxReader = new SAXReader();
		Document document = null;

		try {
			document = saxReader.read(reader);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			try {
				reader.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}

		return document;
	}
	
}
