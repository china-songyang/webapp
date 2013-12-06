package com.saturn.website;

import java.util.ArrayList;
import java.util.List;

public class PaginationUtils {
	private static final int LIST_PAGINATION_NUM = 22;

	public static String getPageText(String text, String indexStr) {
		int index = 1;
		try {
			index = Integer.parseInt(indexStr);
		} catch (Exception e) {
		}

		return getPageTexts(text)[index - 1];
	}

	public static String[] getPageTexts(String text) {
		if (text == null) {
			return new String[] {""};
		}
		
		return text
				.split("<hr style=\"page-break-after:always;\" class=\"ke-pagebreak\" />");
	}

	public static String getPagination(String url, String currentStr, String text) {
		int current = 1;
		try {
			current = Integer.parseInt(currentStr);
		} catch (Exception e) {
		}
		int size = getPageTexts(text).length;
		
		return getPagination(url, current, size, 0);
	}
	
	@SuppressWarnings("rawtypes")
	public static String getPagination(String url, String currentStr, List all) {
		return getPagination(url, currentStr, all, 0);
	}
	
	@SuppressWarnings("rawtypes")
	public static String getPagination(String url, String currentStr, List all, int pageSize) {
		int current = 1;
		try {
			current = Integer.parseInt(currentStr);
		} catch (Exception e) {
		}
		
		if (pageSize <= 0) {
			pageSize = LIST_PAGINATION_NUM;
		}
		int size = all.size() / pageSize + 1;
		
		return getPagination(url, current, size, all.size());
	}
	
	@SuppressWarnings("rawtypes")
	public static List getPaginationList(List all, String currentStr) {
		int current = 1;
		try {
			current = Integer.parseInt(currentStr);
		} catch (Exception e) {
		}
		
		return getPaginationList(all, current);
	}
	//jyb
	@SuppressWarnings("rawtypes")
	public static List getPaginationList(List all, String currentStr, int count) {
		int current = 1;
		try {
			current = Integer.parseInt(currentStr);
		} catch (Exception e) {
		}
		
		if (all == null) {
			return new ArrayList();
		}
		int start = 0 + (current-1) * count;
		int end = Math.min(all.size(), current * count);
		
		return all.subList(start, end);
	}
	
	@SuppressWarnings("rawtypes")
	public static List getPaginationList(List all, int current) {
		if (all == null) {
			return new ArrayList();
		}
		
		int start = 0 + (current-1) * LIST_PAGINATION_NUM;
		int end = Math.min(all.size(), current * LIST_PAGINATION_NUM);
		
		return all.subList(start, end);
	}

	private static String getPagination(String url, int current, int size, int sum) {
		if (size == 1) {
			return "";
		}
		
		StringBuffer buffer = new StringBuffer();
		if (current == 1) {
			buffer.append("首页&nbsp;");
			buffer.append("上一页&nbsp;");
		} else {
			buffer.append(getLink(url, "1", "首页"));
			buffer.append(getLink(url, current - 1 + "", "上一页"));
		}
/*
		for (int i = 1; i <= size; ++i) {
			if (current == i) {
				buffer.append("[" + i + "]&nbsp;");
			} else {
				buffer.append(getLink(url, i + "", "[" + i + "]"));
			}
		}
*/
		if (current == size) {
			buffer.append("下一页&nbsp;");
			buffer.append("尾页&nbsp;");
		} else {
			buffer.append(getLink(url, current + 1 + "", "下一页"));
			buffer.append(getLink(url, size + "", "尾页"));
		}
		
		if (sum == 0) {
			buffer.append("共计" + current+"/"+size + "页&nbsp;");
		} else {
			buffer.append("共计" + sum + "条&nbsp" + size + "页&nbsp;");
		}
		
		return buffer.toString();
	}

	private static String getLink(String url, String index, String text) {
		String link = "<a href=\"" + url + "&index=" + index + "\">" + text
				+ "</a>&nbsp;";
		if (url.indexOf("?") < 0) {
			link = link.replace('&', '?');
		}

		return link;
	}
}
