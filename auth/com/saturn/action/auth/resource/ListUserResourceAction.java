package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.Resource;

public class ListUserResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String userId = request.getParameter("userId");

		return new JsonView(Resource.getAllUserResourceTreeJSON(userId));
	}

	public String requestMapping() {
		return "/app/auth/resource/listUserResource.action";
	}
}
