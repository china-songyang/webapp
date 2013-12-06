package com.saturn.app.web;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SaturnDispatcherServlet extends HttpServlet {

	private static final long serialVersionUID = 490104697474185624L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) {
		this.doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) {
		try {
			WebHelper webHelper = new WebHelper(request, response);
			IView view = webHelper.execute();
			if (view != null) {
				view.dispather(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
