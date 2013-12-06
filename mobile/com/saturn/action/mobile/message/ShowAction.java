package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class ShowAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String show = request.getParameter("show");
		
		MobileMessage.show(show);
		return new JspView("/app/mobile/office/message/show.jsp");
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/office/message/show.action";
	}
}
