package com.saturn.action.website.admin;

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
		
		String cid = "";
		if (ids != null && ids.length > 0) {
			cid = Article.get(ids[0]).getCid();
		}
		
		Article.removes(ids);
		return new JspView("/app/website/admin/listArticle.jsp?cid=" + cid);
	}

	public String requestMapping() {
		return "/app/website/admin/delete.action";
	}

}
