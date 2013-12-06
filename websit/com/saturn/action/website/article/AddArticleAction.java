package com.saturn.action.website.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;

public class AddArticleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Article vo = BeanUtils.getBean(request, Article.class);
		
		if (Article.add(vo) == 1) {
			return new JspView("/app/website/article/show.jsp");
		} else {
			return new JspErrorView("添加文章失败");
		}
	}

	public String requestMapping() {
		return "/app/website/article/add.action";
	}
	
}
