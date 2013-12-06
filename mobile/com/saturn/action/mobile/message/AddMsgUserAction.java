package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.DateUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class AddMsgUserAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String type = request.getParameter("type");
		String msgId = request.getParameter("id");
		String ids = request.getParameter("ids");
		String[] userId = ids.split("__"); 
		String sendTime = DateUtils.getSystemTime();
		
		MobileMessage.addUsersToMsg(msgId,userId,type,sendTime);
		
		return new JspView("/app/mobile/office/message/showMessageUser.jsp");
		
		/*if("1".equals(type)) {
			return new JspView("/app/mobile/office/message/showMessageUser.jsp");
		} else if("2".equals(type)){
			return new JspView("/app/mobile/office/meeting/showMeetingUser.jsp");
		}
		return null;*/
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/message/addMsgUser.action";
	}
}
