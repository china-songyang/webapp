package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Resource;

public class QueryResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String id = request.getParameter("id");
		Resource role = Resource.get(id);
		
		request.setAttribute("resource", role);
		return new JspView("/app/auth/resource/editResource.jsp");
	}

	public String requestMapping() {
		return "/app/auth/resource/queryResource.action";
	}

}
