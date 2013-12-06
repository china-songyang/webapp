package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Content;

public class QueryContentAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Content vo = Content.get(id);
		
		request.setAttribute("content", vo);
		return new JspView("/app/website/content/edit.jsp");
	}

	public String requestMapping() {
		return "/app/website/content/query.action";
	}

}
