package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.Meeting;

public class DeteleMeetingAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String idstr = request.getParameter("ids");
		String[] ids=idstr.split("__");
		
		Meeting.removes(ids);
		Meeting.removeReUsers(ids);
			return new JspView("/app/mobile/office/meeting/showMeeting.jsp");
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/meeting/deleteMeeting.action";
	}
}
