package com.saturn.action.auth.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class UpdateUserResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String userId = request.getParameter("userId");
		String checkedId = request.getParameter("checkedIds");
		User user;

		if (checkedId != "") {
			int result = User.updateUserResource(userId, checkedId.split(","));
			if (result >= 1) {
				user = User.get(userId);
			} else {
				return new JspErrorView("修改角色的资源失败！");
			}
		} else {
			User.removeAllResource(userId);
			user = User.get(userId);
		}

		request.setAttribute("user", user);
		return new JspView("/app/auth/user/showUserResources.jsp");
	}

	public String requestMapping() {
		return "/app/auth/user/updateUserResource.action";
	}

}
