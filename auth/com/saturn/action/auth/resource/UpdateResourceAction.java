package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Resource;

public class UpdateResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Resource resource = BeanUtils.getBean(request, Resource.class);
		
		if (Resource.edit(resource) == 1) {
			return new JspView("/app/auth/resource/showResources.jsp");
		} else {
			return new JspErrorView("修改资源失败");
		}
	}

	public String requestMapping() {
		return "/app/auth/resource/updateResource.action";
	}

}
