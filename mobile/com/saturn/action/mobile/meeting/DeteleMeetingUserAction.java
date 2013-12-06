package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.Meeting;

public class DeteleMeetingUserAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		String ids = request.getParameter("ids");
		String [] userIds = ids.split("__");
		
		Meeting.removeMeetingUser(id, userIds);
		
		return new JspView("/app/mobile/office/meeting/showMeetingUser.jsp");
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/office/meeting/deleteMeetingUser.action";
	}
}
