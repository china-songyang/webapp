package com.saturn.app.web.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.WebHelper;

public class JspErrorView extends JspView {
	
	private String message;
	
	public JspErrorView(String message) {
		super(WebHelper.ERROR_JSP);
		
		this.message = message;
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {
		
		request.setAttribute(WebHelper.ERROR_MESSAGE, this.message);
		super.dispather(request, response);
	}
}
