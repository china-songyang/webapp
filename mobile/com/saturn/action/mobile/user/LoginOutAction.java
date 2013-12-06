package com.saturn.action.mobile.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class LoginOutAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		User user = (User)request.getSession().getAttribute("authUser");
		String url = request.getParameter("urlValue");
		
		if (user != null) {
			request.getSession().removeAttribute("authUser");
		} 
		
		if (url == null || url.equals("")) {
			return new JspView("/app/mobile/login.jsp");
		} else {
			url = url.replace("%2F", "/");
			return new JspView(url);
		}
	}

	public String requestMapping() {
		return "/app/mobile/user/logout.action";
	}
}
