package com.saturn.action.system.dict;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.system.Dict;

public class DeleteDictAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String idStr = request.getParameter("ids");
		String[] ids = idStr.split("__");
		
		Dict.removes(ids);
		return new JspView("/app/system/dict/showDicts.jsp");
	}

	public String requestMapping() {
		return "/app/system/dict/deleteDict.action";
	}

}
