package com.saturn.action.website.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Image;

public class AddImgAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Image vo = BeanUtils.getBean(request, Image.class);
		String id = vo.getArticleId();
		if (Image.add(vo) == 1) {
			return new JspView("/app/website/admin/listImg.jsp?id=" + id);
		} else {
			return new JspErrorView("添加图片失败");
		}
	}

	public String requestMapping() {
		return "/app/website/admin/addImg.action";
	}
}
