package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.Meeting;

public class QueryMetUserAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String id = request.getParameter("id");
		Meeting meeting = Meeting.get(id);

		request.setAttribute("meeting", meeting);
		
			return new JspView("/app/mobile/office/meeting/showMeetingUser.jsp?id="+id);
	}

	@Override
	public String requestMapping() {
		return "/app/mobile/meeting/QueryMetUser.action";
	}
}
