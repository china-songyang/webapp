package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.Meeting;

public class QueryMeetingAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Meeting vo = Meeting.get(id);
		
		request.setAttribute("meeting", vo);
		return new JspView("/app/mobile/office/meeting/editMeeting.jsp");
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/meeting/queryMeeting.action";
	}
}
