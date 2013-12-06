package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.website.Content;

public class ListContentTreeAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String cid = request.getParameter("cid");
		
		return new JsonView(Content.getAllContentTreeJSON(cid));
	}

	public String requestMapping() {
		return "/app/website/content/tree.action";
	}
}
