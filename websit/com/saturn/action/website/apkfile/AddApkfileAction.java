package com.saturn.action.website.apkfile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Apkfile;

public class AddApkfileAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Apkfile vo = BeanUtils.getBean(request, Apkfile.class);
		
		if (Apkfile.add(vo) == 1) {
			return new JspView("/app/mobile/office/apkfile/show.jsp");
		} else {
			return new JspErrorView("添加失败");
		}
	}

	public String requestMapping() {
		return "/app/mobile/office/apkfile/add.action";
	}
	
}
