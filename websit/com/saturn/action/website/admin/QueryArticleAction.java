package com.saturn.action.website.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;

public class QueryArticleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Article vo = Article.get(id);
		String cid = vo.getCid();
		
		request.setAttribute("article", vo);
		return new JspView("/app/website/admin/editArticle.jsp?cid=" + cid);
	}

	public String requestMapping() {
		return "/app/website/admin/query.action";
	}

}
