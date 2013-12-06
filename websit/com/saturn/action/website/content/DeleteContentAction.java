package com.saturn.action.website.content;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Content;

public class DeleteContentAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String parentId = request.getParameter("parentId")!=null?request.getParameter("parentId").trim():"";
		String[] ids = idStr.split("__");
		
		Content.removes(ids);
		return new JspView("/app/website/content/show.jsp?parentId=" + parentId);
	}

	public String requestMapping() {
		return "/app/website/content/delete.action";
	}

}
