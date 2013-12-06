package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class DeleteMessageAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String idstr = request.getParameter("ids");
		String[] ids=idstr.split("__");
		
		String type = request.getParameter("type");
		
		MobileMessage.removes(ids);
		MobileMessage.removeReUsers(ids);
		
		if("1".equals(type)) {
			return new JspView("/app/mobile/office/message/show.jsp");
		} else if("2".equals(type)) {
			return new JspView("/app/mobile/office/meeting/show.jsp");
		}
		return null;
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/office/message/deleteMessage.action";
	}
}
