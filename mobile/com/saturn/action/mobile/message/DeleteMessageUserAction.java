package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class DeleteMessageUserAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		String ids = request.getParameter("ids");
		String [] userIds = ids.split("__");
		
		String type = request.getParameter("type");
		MobileMessage.removeMsgUser(id, userIds);
		
		if("1".equals(type)) {
			return new JspView("/app/mobile/office/message/showMessageUser.jsp");
		} else if("2".equals(type)) {
			return new JspView("/app/mobile/office/meeting/showMeetingUser.jsp");
		}
		return null;
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/office/message/deleteMsgUser.action";
	}
}
