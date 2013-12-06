package com.saturn.action.auth.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class QueryUserResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String userId = request.getParameter("id");
		User user = User.get(userId);
		
		request.setAttribute("user", user);
		return new JspView("/app/auth/user/showUserResources.jsp");
	}

	public String requestMapping() {
		return "/app/auth/user/queryUserRecource.action";
	}

}
