package com.saturn.action.auth.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.CodeUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.User;

public class ChangeUserPasswordAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String userId = request.getParameter("id");
		String old = request.getParameter("old");
		String newP = request.getParameter("newP");

		old = CodeUtils.encode(old);
		User user = User.get(userId);
		if (user.getPassword().equals(old)) {
			newP = CodeUtils.encode(newP);
			user.setPassword(newP);
			if (User.edit(user) == 1) {
				return new JspView("/app/auth/user/changePassword.jsp?result=修改成功");
			} else {
				return new JspView("/app/auth/user/changePassword.jsp?result=修改失败");
			}
		} else {
			return new JspView("/app/auth/user/changePassword.jsp?result=密码不正确");
		}
	}

	public String requestMapping() {
		return "/app/auth/user/changePassword.action";
	}

}
