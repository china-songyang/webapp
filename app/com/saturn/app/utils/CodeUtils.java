package com.saturn.app.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.apache.log4j.Logger;

import sun.misc.BASE64Encoder;

public class CodeUtils {
	private static Logger logger = LogManager.getLogger(LogManager.LOG_KEY_APP);

	private static MessageDigest MD5 = null;

	static {
		try {
			MD5 = MessageDigest.getInstance("MD5");

		} catch (NoSuchAlgorithmException ex) {
			logger.debug(ex);
		}
	}

	public static String encode(String value) {
		/*String result = "";*/
		StringBuffer md5StrBuff = new StringBuffer();

		if (value == null) {
			return md5StrBuff.toString();
		}

		MD5.reset();
		try {
			MD5.update(value.getBytes("utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}

		try {
			byte[] byteArray = MD5.digest();

			for (int i = 0; i < byteArray.length; i++) {
				if (Integer.toHexString(0xFF & byteArray[i]).length() == 1)
					md5StrBuff.append("0").append(
							Integer.toHexString(0xFF & byteArray[i]));
				else
					md5StrBuff.append(Integer.toHexString(0xFF & byteArray[i]));
			}

			/* result = baseEncoder.encode(MD5.digest(value.getBytes("utf-8"))); */
		} catch (Exception ex) {
		}

		return md5StrBuff.toString();
	}
}
