package com.saturn.action.auth.organization;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Organization;

public class DeleteOrganizationAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Organization.removes(ids);
		return new JspView("/app/auth/organization/showOrganizations.jsp");
	}

	public String requestMapping() {
		return "/app/auth/organization/deleteOrganization.action";
	}

}
