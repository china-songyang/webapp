package com.saturn.action.website.apkfile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Apkfile;

public class DeleteApkfileAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Apkfile.removes(ids);
		return new JspView("/app/mobile/office/apkfile/show.jsp");
	}

	public String requestMapping() {
		return "/app/mobile/office/apkfile/delete.action";
	}

}
