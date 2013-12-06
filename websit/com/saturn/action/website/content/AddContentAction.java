package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Content;

public class AddContentAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Content vo = BeanUtils.getBean(request, Content.class);
		
		if (Content.add(vo) == 1) {
			return new JspView("/app/website/content/show.jsp");
		} else {
			return new JspErrorView("添加网站目录失败");
		}
	}

	public String requestMapping() {
		return "/app/website/content/add.action";
	}
	
}
