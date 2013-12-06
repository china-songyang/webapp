package com.saturn.action.auth.role;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Role;

public class UpdateRoleResource implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String roleId = request.getParameter("roleId");
		String checkedId = request.getParameter("checkedIds");
		Role role;

		if (checkedId != "") {
			int result = Role.updateRoleResource(roleId, checkedId.split(","));
			if (result >= 1) {
				role = Role.get(roleId);
			} else {
				return new JspErrorView("修改角色的资源失败失败！");
			}
		} else {
			Role.removeAllResource(roleId);
			role = Role.get(roleId);
		}

		request.setAttribute("role", role);
		return new JspView("/app/auth/role/showRoleResource.jsp");

	}

	public String requestMapping() {
		return "/app/auth/role/updateRoleResource.action";
	}

}
