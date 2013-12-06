package com.saturn.action.auth.role;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Role;

public class AddRoleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Role role = BeanUtils.getBean(request, Role.class);
		
		if (Role.add(role) == 1) {
			return new JspView("/app/auth/role/showRoles.jsp");
		} else {
			return new JspErrorView("添加角色失败");
			
		}
	}

	public String requestMapping() {
		return "/app/auth/role/addRole.action";
	}
	
}
