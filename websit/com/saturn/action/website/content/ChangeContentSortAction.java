package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Content;

public class ChangeContentSortAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String firstId = request.getParameter("first");
		String secondId = request.getParameter("second");
		String parentId = request.getParameter("parentId");
		
		Content.changeSort(firstId, secondId);
		if (parentId != null) {
			return new JspView("/app/website/content/show.jsp?parentId=" + parentId);
		} else {
			return new JspView("/app/website/content/show.jsp");
		}
	}

	public String requestMapping() {
		return "/app/website/content/change.action";
	}

}
