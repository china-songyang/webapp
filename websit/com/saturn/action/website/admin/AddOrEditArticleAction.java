package com.saturn.action.website.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;

public class AddOrEditArticleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		Article vo = BeanUtils.getBean(request, Article.class);

		if (Article.addOrEdit(vo) == 1) {
			return new JspView("/app/website/admin/editContentArticle.jsp?cid="
					+ vo.getCid() + "&result=true");
		} else {
			return new JspView("/app/website/admin/editContentArticle.jsp?cid="
					+ vo.getCid() + "&result=false");
		}
	}

	public String requestMapping() {
		return "/app/website/admin/addOrEdit.action";
	}

}
