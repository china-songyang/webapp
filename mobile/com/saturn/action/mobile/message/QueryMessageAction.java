package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class QueryMessageAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		MobileMessage vo = MobileMessage.get(id);
		request.setAttribute("mobileMessage", vo);
		
		String type = request.getParameter("type");
		if("1".equals(type)) {
			return new JspView("/app/mobile/office/message/edit.jsp");
		} else if("2".equals(type)){
			return new JspView("/app/mobile/office/meeting/edit.jsp");
		}
		return null;
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/office/message/queryMessage.action";
	}
}
