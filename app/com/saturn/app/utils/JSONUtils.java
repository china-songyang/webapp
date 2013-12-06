package com.saturn.app.utils;

import java.util.List;

import org.apache.log4j.Logger;

public class JSONUtils {
	private static Logger logger = LogManager.getLogger(LogManager.LOG_KEY_APP);

	private JSONUtils() {

	}

	public static String getDataGridJSON(int total, List<?> rows) {
		return getDataGridJSON(total, rows, null);
	}

	public static String getDataGridJSON(int total, List<?> rows, List<?> footer) {
		StringBuffer buffer = new StringBuffer();

		buffer.append("{");

		buffer.append("\"total\":" + total + ",");
		buffer.append("\"rows\":" + rows);
		if (footer != null) {
			buffer.append(",\"footer\":" + footer);
		}

		buffer.append("}");
		logger.debug("DataGridJSON:" + buffer.toString());
		return buffer.toString();
	}
	
}
