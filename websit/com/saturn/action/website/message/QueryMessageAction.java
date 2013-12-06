package com.saturn.action.website.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Message;

public class QueryMessageAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Message vo = Message.get(id);
		
		request.setAttribute("message", vo);
		return new JspView("/app/website/message/edit.jsp");
	}

	public String requestMapping() {
		return "/app/website/message/query.action";
	}

}
