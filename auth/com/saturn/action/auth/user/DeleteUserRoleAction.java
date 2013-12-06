package com.saturn.action.auth.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class DeleteUserRoleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String userId = request.getParameter("id");
		String idStr = request.getParameter("ids");
		String[] roleIds = idStr.split("__");
		
		User.removeRoles(userId, roleIds);
		return new JspView("/app/auth/user/showUserRoles.jsp?id="+userId);
	}

	public String requestMapping() {
		return "/app/auth/user/deleteUserRole.action";
	}

}
