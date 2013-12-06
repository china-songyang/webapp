package com.saturn.action.website.admin;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Article;
import com.saturn.website.Content;

public class AddArticleAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		Article vo = BeanUtils.getBean(request, Article.class);
		String cid = request.getParameter("cid");
		
		String url = request.getRequestURL().toString();
		String[] urls = url.split("/");
		
		String imageUrl = vo.getImageUrl();
		String [] imageUrls = imageUrl.split(";");
		String imageU = "";
		
		for(int i=0; i<imageUrls.length; i++) {
			imageU += "http://"+urls[2]+""+imageUrls[i]+"" + ";";
		}
		
		vo.setImageUrl(imageU);
		
		Content content = Content.get(cid);
		String name = content.getName();
		vo.setType(cid);
		vo.setTypeName(name);
		
		Article ar = Article.getByType(vo.getType());
		if (ar.getPoint() == null || "".equals(ar.getPoint())) {
			vo.setPoint("1");
		} else {
			String point = "" + (Integer.parseInt(ar.getPoint()) + 1);
			vo.setPoint(point);
		}
		
		if (Article.add(vo) == 1) {
			return new JspView("/app/website/admin/listArticle.jsp?cid=" + cid);
		} else {
			return new JspErrorView("添加文章失败");
		}
	}

	public String requestMapping() {
		return "/app/website/admin/add.action";
	}

}
