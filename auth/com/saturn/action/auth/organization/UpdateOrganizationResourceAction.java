package com.saturn.action.auth.organization;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Organization;

public class UpdateOrganizationResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String organizationId = request.getParameter("organizationId");
		String checkedId = request.getParameter("checkedIds");
		Organization organization;

		if (checkedId != "") {
			int result = Organization.updateOrganizationResource(organizationId, checkedId.split(","));
			if (result >= 1) {
				organization = Organization.get(organizationId);
			} else {
				return new JspErrorView("修改角色的资源失败失败！");
			}
		} else {
			Organization.removeAllResource(organizationId);
			organization = Organization.get(organizationId);
		}

		request.setAttribute("organization", organization);
		return new JspView("/app/auth/organization/showOrganizationResource.jsp");

	}

	public String requestMapping() {
		return "/app/auth/organization/updateOrganizationResource.action";
	}

}
