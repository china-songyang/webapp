package com.saturn.action.website.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Message;

public class DeleteMessageAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Message.removes(ids);
		
		return new JspView("/app/website/message/show.jsp");
	}

	public String requestMapping() {
		return "/app/website/message/deleteMessage.action";
	}

}
