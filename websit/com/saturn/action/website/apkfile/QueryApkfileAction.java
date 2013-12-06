package com.saturn.action.website.apkfile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.website.Apkfile;

public class QueryApkfileAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Apkfile vo = Apkfile.get(id);
		
		request.setAttribute("apkfile", vo);
		return new JspView("/app/mobile/office/apkfile/edit.jsp");
	}

	public String requestMapping() {
		return "/app/mobile/office/apkfile/query.action";
	}

}
