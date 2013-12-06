package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class QueryMsgUserAction implements IAction {
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String id = request.getParameter("id");
		MobileMessage msg = MobileMessage.get(id);
		String type = request.getParameter("type");

		request.setAttribute("message", msg);
		
		if("1".equals(type)) {
			return new JspView("/app/mobile/office/message/showMessageUser.jsp?type=" + type + "&id="+id);
		} else if("2".equals(type)) {
			return new JspView("/app/mobile/office/meeting/showMeetingUser.jsp?type=" + type + "&id="+id);
		}
		return null;
	}

	@Override
	public String requestMapping() {
		return "/app/mobile/message/QueryMsgUser.action";
	}
}
