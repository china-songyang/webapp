package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Content;

public class UpdateContentAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Content dict = BeanUtils.getBean(request, Content.class);
		
		if (Content.edit(dict) == 1) {
			return new JspView("/app/website/content/show.jsp");
		} else {
			return new JspErrorView("修改网站目录失败");
		}
	}

	public String requestMapping() {
		return "/app/website/content/update.action";
	}

}
