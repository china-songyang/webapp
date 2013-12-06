package com.saturn.action.auth.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.CodeUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class LoginUserAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String id = request.getParameter("id");
		String password = request.getParameter("password");
		String url = request.getParameter("urlValue");
		
		password = CodeUtils.encode(password);
		User user = User.get(id);
		if (user != null) {
			if (user.getPassword().equals(password)) {
				request.getSession().setAttribute("authUser", user);
				
				if (url == null || url.equals("")) {
					return new JspView("/app/main.jsp");
				} else {
					url = url.replace("%2F", "/");
					return new JspView(url);
				}
			} else {
				return new JspErrorView("密码不正确");
			}
		} else {
			return new JspErrorView("用户不存在");
		}
		
	}

	public String requestMapping() {
		return "/app/auth/user/login.do";
	}

}