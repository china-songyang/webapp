package com.saturn.app.web;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.view.JspView;

public class WebHelper {

	public static final String ERROR_JSP = "/error.jsp";

	public static final String ERROR_MESSAGE = "__ERROR_MESSAGE__";
	
	public static final String ERROR_MESSAGE_STACK = "__ERROR_MESSAGE_STACK__";

	private HttpServletRequest request;

	private HttpServletResponse response;

	public WebHelper(HttpServletRequest request, HttpServletResponse response) {
		this.request = request;
		this.response = response;
	}

	public HttpServletRequest getRequest() {
		return request;
	}

	public HttpServletResponse getResponse() {
		return response;
	}

	public IView execute() throws Exception {
		try {
			String actionKey = this.getActionKey(this.getRequest()
					.getRequestURI());

			IAction action = ActionManager.get(actionKey);
			return action.execute(request, response);
		} catch (Exception e) {
			StringWriter sw = new StringWriter();
			e.printStackTrace(new PrintWriter(sw));
			
			request.setAttribute(ERROR_MESSAGE, e.getMessage());
			request.setAttribute(ERROR_MESSAGE_STACK, sw.toString());
			return new JspView(ERROR_JSP);
		}
	}

	private String getActionKey(String requestURI) {
		return requestURI.substring(requestURI.indexOf("/", 1));
	}
}
