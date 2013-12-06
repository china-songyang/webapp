package com.saturn.action.auth.organization;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Organization;

public class UpdateOrganizationAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Organization organization = BeanUtils.getBean(request, Organization.class);
		
		if (Organization.edit(organization) == 1) {
			return new JspView("/app/auth/organization/showOrganizations.jsp");
		} else {
			return new JspErrorView("修改组织结构失败");
		}
	}

	public String requestMapping() {
		return "/app/auth/organization/updateOrganization.action";
	}

}
