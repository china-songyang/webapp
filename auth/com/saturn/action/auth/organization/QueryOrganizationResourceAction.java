package com.saturn.action.auth.organization;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Organization;

public class QueryOrganizationResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String organizationId = request.getParameter("id");
		Organization organization = Organization.get(organizationId);
		
		request.setAttribute("organization", organization);
		return new JspView("/app/auth/organization/showOrganizationResource.jsp");
	}

	public String requestMapping() {
		return "/app/auth/organization/queryOrganizationRecource.action";
	}

}
