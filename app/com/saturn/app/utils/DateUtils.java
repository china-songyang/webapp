package com.saturn.app.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * 处理系统时间信息
 * TODO:目前不支持多线程，应考虑使用apache的相关实现
 * 
 * @author WenJian
 */
public abstract class DateUtils {

	private static String saturnDefaultDateFormat = "yyyy-MM-dd";

	private static String saturnDefaultTimeFormat = "yyyy-MM-dd HH:mm:ss";

	private static String defaultDateRegExpr = "[0-9]{4}\\-([01])?[0-9]\\-([0123])?[0-9](\\s*[0-9]{2}:[0-9]{2}:[0-9]{2})?";

	private static String dateFormat = saturnDefaultDateFormat;

	private static String timeFormat = saturnDefaultTimeFormat;

	private static String dateRegExpr = defaultDateRegExpr;

	public static String getSysteTimeMillisecond(Date date) {
		return new SimpleDateFormat("HH:mm:ss SSS").format(date);
	}
	
	/**
	 * 获得系统时间，默认格式yyyy-MM-dd HH:mm:ss
	 * 
	 * @return
	 */
	public static String getSystemTime() {
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat(timeFormat);
		return format.format(date);
	}

	/**
	 * 获得系统日期，默认格式yyyy-MM-dd
	 * @return
	 */
	public static String getSystemDate() {
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat(dateFormat);
		return format.format(date);
	}

	/**
	 * 获得系统时间，根据给定格式
	 * @param formatStr
	 * @return
	 */
	public static String getSystemTime(String formatStr) {
		if (!isValidFormat(formatStr)) {
			formatStr = saturnDefaultTimeFormat;
		}

		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat(formatStr);
		return format.format(date);
	}

	/**
	 * 获得系统日期，根据给定格式
	 * @param formatStr
	 * @return
	 */
	public static String getSystemDate(String formatStr) {
		if (!isValidFormat(formatStr)) {
			formatStr = saturnDefaultDateFormat;
		}
		
		Date date = new Date();
		SimpleDateFormat format = new SimpleDateFormat(formatStr);
		return format.format(date);
	}

	/**
	 * 把字符串变成日期
	 * 
	 * @param dateStr
	 * @return
	 */
	public static Date getDate(String dateStr) {
		if (isValidDate(dateStr)) {
			SimpleDateFormat format = new SimpleDateFormat(dateFormat);
			Date date = null;
			try {
				date = format.parse(dateStr);
				return date;
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		return null;
	}

	/**
	 * 把字符串变成时间
	 * @param dateStr
	 * @return
	 */
	public static Date getDateTime(String dateStr) {
		if (isValidDate(dateStr)) {
			SimpleDateFormat format = new SimpleDateFormat(timeFormat);
			Date date = null;
			try {
				date = format.parse(dateStr);
				return date;
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	public static boolean isValidFormat(String formatStr) {
		// TODO: 检查具体的时间日期的格式,目前只判断了是否为空
		if (formatStr != null) {
			return true;
		}
		return false;
	}

	public static boolean isValidDate(String dateStr) {
		if (dateStr != null) {
			if (dateStr.matches(dateRegExpr)) {
				if (checkDate(dateStr)) {
					return true;
				}
			}
		}
		return false;
	}
	
	public static String getDateStr(String dateStr, String format) {
		Date date = DateUtils.getDateTime(dateStr);
		SimpleDateFormat simpleFormat = new SimpleDateFormat(format);
		return simpleFormat.format(date);
	}

	public static Date getDate(String dateStr, String format)
			throws ParseException {
		if (isValidDate(dateStr)) {
			SimpleDateFormat formatStr = new SimpleDateFormat(format);
			Date date = null;
			try {
				date = formatStr.parse(dateStr);
				return date;
			} catch (ParseException e) {
				throw e;
			}
		}
		return null;
	}

	public static boolean checkDate(String dateStr) {
		// TODO: 检查日期格式是否正确
		return true;
	}

	public static String getDateFormat() {
		return dateFormat;
	}

	public static void setDateFormat(String dateFormat) {
		DateUtils.dateFormat = dateFormat;
	}

	public static String getTimeFormat() {
		return timeFormat;
	}

	public static void setTimeFormat(String timeFormat) {
		DateUtils.timeFormat = timeFormat;
	}

	public static String getDateRegExpr() {
		return dateRegExpr;
	}

	public static void setDateRegExpr(String dateRegExpr) {
		DateUtils.dateRegExpr = dateRegExpr;
	}
}
