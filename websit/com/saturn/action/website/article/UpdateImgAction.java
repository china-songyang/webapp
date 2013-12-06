package com.saturn.action.website.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Image;

public class UpdateImgAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Image image = BeanUtils.getBean(request, Image.class);
		String articleId = image.getArticleId();
		if (Image.edit(image) == 1) {
			return new JspView("/app/website/admin/listImg.jsp?id=" + articleId);
		} else {
			return new JspErrorView("修改新闻图片失败");
		}
	}

	public String requestMapping() {
		return "/app/website/admin/updateImage.action";
	}
}
