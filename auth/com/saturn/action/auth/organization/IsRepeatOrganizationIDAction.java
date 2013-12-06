package com.saturn.action.auth.organization;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.Organization;

public class IsRepeatOrganizationIDAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String id = request.getParameter("id");

		if (Organization.get(id) != null) {
			return new JsonView("true");
		}
		return new JsonView("false");
	}

	public String requestMapping() {
		return "/app/auth/organization/isRepeatOrganizationId.action";
	}

}
