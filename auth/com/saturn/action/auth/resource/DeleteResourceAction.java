package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Resource;

public class DeleteResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Resource.removes(ids);
		return new JspView("/app/auth/resource/showResources.jsp");
	}

	public String requestMapping() {
		return "/app/auth/resource/deleteResource.action";
	}

}
