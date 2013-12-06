package com.saturn.action.website.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Message;

public class UpdateMessageAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Message dict = BeanUtils.getBean(request, Message.class);
		
		if (Message.edit(dict) == 1) {
			return new JspView("/app/website/message/show.jsp");
		} else {
			return new JspErrorView("修改留言失败");
		}
	}

	public String requestMapping() {
		return "/app/website/message/update.action";
	}

}
