package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.DateUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.Meeting;

public class AddMetUserAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String msgId = request.getParameter("id");
		String ids = request.getParameter("ids");
		String[] userId = ids.split("__"); 
		String sendTime = DateUtils.getSystemTime();
		
		Meeting.addUsersToMet(msgId,userId,sendTime);
			return new JspView("/app/mobile/office/meeting/showMeetingUser.jsp");
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/meeting/addMetUser.action";
	}
}
