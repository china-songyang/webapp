package com.saturn.action.website.article;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Image;

public class QueryImgByIdAction implements IAction{
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Image vo = Image.get(id);
		
		request.setAttribute("img", vo);
		return new JspView("/app/website/admin/editImg.jsp");
	}

	public String requestMapping() {
		return "/app/website/admin/queryById.action";
	}
}
