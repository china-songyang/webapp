package com.saturn.action.website.apkfile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Apkfile;

public class UpdateApkfileAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Apkfile apkfile = BeanUtils.getBean(request, Apkfile.class);
		
		if (Apkfile.edit(apkfile) == 1) {
			return new JspView("/app/mobile/office/apkfile/show.jsp");
		} else {
			return new JspErrorView("修改失败");
		}
	}

	public String requestMapping() {
		return "/app/mobile/office/apkfile/update.action";
	}

}
