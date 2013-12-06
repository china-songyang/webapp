package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.auth.Resource;

public class ChangeResourceSortAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String firstId = request.getParameter("first");
		String secondId = request.getParameter("second");
		
		Resource.changeSort(firstId, secondId);
		return new JspView("/app/auth/resource/showResources.jsp");
	}

	public String requestMapping() {
		return "/app/auth/resource/change.action";
	}

}
