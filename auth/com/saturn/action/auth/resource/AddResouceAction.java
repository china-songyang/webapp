package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Resource;

public class AddResouceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Resource resource = BeanUtils.getBean(request, Resource.class);
		
		if ("".equals(resource.getParentId())) {
			resource.setParentId(null);
		}
		if (Resource.add(resource) == 1) {
			return new JspView("/app/auth/resource/showResources.jsp");
		} else {
			return new JspErrorView("添加资源失败");
			
		}
	}

	public String requestMapping() {
		return "/app/auth/resource/addResource.action";
	}
	
}
