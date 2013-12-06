package com.saturn.action.auth.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class LogoutUserAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		User user = (User)request.getSession().getAttribute("authUser");
		String url = request.getParameter("urlValue");
		
		if (user != null) {
			request.getSession().removeAttribute("authUser");
		} 
		
		if (url == null || url.equals("")) {
			return new JspView("/app/login.jsp");
		} else {
			url = url.replace("%2F", "/");
			return new JspView(url);
		}
	}

	public String requestMapping() {
		return "/app/auth/user/logout.action";
	}

}