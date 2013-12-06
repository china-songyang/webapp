package com.saturn.action.auth.role;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Role;

public class DeleteRoleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Role.removes(ids);
		return new JspView("/app/auth/role/showRoles.jsp");
	}

	public String requestMapping() {
		return "/app/auth/role/deleteRole.action";
	}

}
