package com.saturn.action.website.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;

public class DeleteArticleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Article.removes(ids);
		return new JspView("/app/website/article/show.jsp");
	}

	public String requestMapping() {
		return "/app/website/article/delete.action";
	}

}
