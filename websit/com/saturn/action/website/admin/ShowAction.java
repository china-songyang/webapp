package com.saturn.action.website.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;

public class ShowAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String show = request.getParameter("show");
		String cid = Article.get(show).getCid();

		Article.show(show);
		return new JspView("/app/website/admin/listArticle.jsp?cid=" + cid);
	}

	public String requestMapping() {
		return "/app/website/admin/show.action";
	}

}
