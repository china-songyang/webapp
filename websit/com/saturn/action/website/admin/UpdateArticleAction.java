package com.saturn.action.website.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;

public class UpdateArticleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		Article article = BeanUtils.getBean(request, Article.class);
		String cid = article.getCid();

		if (Article.edit(article) == 1) {
			return new JspView("/app/website/admin/listArticle.jsp?cid=" + cid);
		} else {
			return new JspErrorView("修改文章失败");
		}
	}

	public String requestMapping() {
		return "/app/website/admin/update.action";
	}

}
