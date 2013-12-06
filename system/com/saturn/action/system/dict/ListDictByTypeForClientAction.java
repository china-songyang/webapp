package com.saturn.action.system.dict;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.system.Dict;

public class ListDictByTypeForClientAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String type = request.getParameter("type");
		return new JsonView(Dict.getDictJSONByType(type));
	}

	public String requestMapping() {
		return "/app/system/dict/listDictByTypeForClient.do";
	}

}
