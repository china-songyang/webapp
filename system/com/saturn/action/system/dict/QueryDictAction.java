package com.saturn.action.system.dict;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;
import com.saturn.system.Dict;

public class QueryDictAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String id = request.getParameter("id");
		Dict dict = Dict.get(id);
		
		request.setAttribute("dict", dict);
		return new JspView("/app/system/dict/editDict.jsp");
	}

	public String requestMapping() {
		return "/app/system/dict/queryDict.action";
	}

}
