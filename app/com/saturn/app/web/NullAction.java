package com.saturn.app.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.LogManager;
import com.saturn.app.web.view.JspView;

public class NullAction implements IAction {

	private String key;
	
	public NullAction(String key) {
		this.key = key;
	}

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String errorMsg = "The Action key[" + key + "] is not exist in ActionManager";
		
		request.setAttribute(WebHelper.ERROR_MESSAGE, errorMsg);
		LogManager.getLogger(LogManager.LOG_KEY_APP).debug(errorMsg);
		
		return new JspView(WebHelper.ERROR_JSP);
	}

	public String requestMapping() {
		return "";
	}

}
