package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.website.Content;

public class IsRepeatContentIDAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String id = request.getParameter("id");

		if (Content.get(id) != null) {
			return new JsonView("true");
		}
		return new JsonView("false");
	}

	public String requestMapping() {
		return "/app/website/content/isRepeatId.action";
	}

}
