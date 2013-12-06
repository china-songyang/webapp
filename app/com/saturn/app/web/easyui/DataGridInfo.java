package com.saturn.app.web.easyui;

import javax.servlet.http.HttpServletRequest;

public class DataGridInfo {
	
	private String sortId;
	
	private String oreder = "desc";
	
	private String rows = null;
	
	private String page = null;
	
	public DataGridInfo(HttpServletRequest request) {
		String[] sorts = request.getParameterValues("sort");
		if (sorts != null && sorts.length >= 1) {
			this.sortId = sorts[0];
		}
		
		String[] orders = request.getParameterValues("order");
		if (orders != null && orders.length >= 1) {
			this.oreder = orders[0];
		}
		
		String[] rowses = request.getParameterValues("rows");
		if (rowses != null && rowses.length >= 1) {
			this.rows = rowses[0];
		}
		
		String[] pages = request.getParameterValues("page");
		if (pages != null && pages.length >= 1) {
			this.page = pages[0];
		}
	}

	public String getSortId() {
		return sortId;
	}

	public String getOreder() {
		return oreder;
	}

	public String getRows() {
		return rows;
	}

	public String getPage() {
		return page;
	}
	
	public String getStartPage() {
		int pageInt = 1;
		int rowsInt = 10;
		
		try {
			pageInt = Integer.parseInt(this.page);
		} catch (NumberFormatException e) {
		}
		
		try {
			rowsInt = Integer.parseInt(this.rows);
		} catch (NumberFormatException e) {
		}
		
		return (pageInt - 1) * rowsInt + "";
	}
}
