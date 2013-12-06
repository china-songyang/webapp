package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.Meeting;

public class UpdateMeetingAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		Meeting vo = BeanUtils.getBean(request, Meeting.class);
		
		if(Meeting.edit(vo) == 1) {
			return new JspView("/app/mobile/office/meeting/showMeeting.jsp");
		} else {
			return new JspErrorView("修改信息失败");
		}
	}
	@Override
	public String requestMapping() {
		// TODO Auto-generated method stub
		return "/app/mobile/meeting/updateMeeting.action";
	}
}
