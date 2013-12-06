package com.saturn.action.auth.role;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Role;

public class QueryResourceRoleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Role role = Role.get(id);
		
		request.setAttribute("role", role);
		return new JspView("/app/auth/role/showRoleResource.jsp");
	}

	public String requestMapping() {
		return "/app/auth/role/queryResourceRole.action";
	}

}
