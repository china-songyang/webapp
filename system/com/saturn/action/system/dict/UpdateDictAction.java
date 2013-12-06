package com.saturn.action.system.dict;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.system.Dict;

public class UpdateDictAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		Dict dict = BeanUtils.getBean(request, Dict.class);
		
		if (Dict.edit(dict) == 1) {
			return new JspView("/app/system/dict/showDicts.jsp");
		} else {
			return new JspErrorView("修改数据字典失败");
		}
	}

	public String requestMapping() {
		return "/app/system/dict/updateDict.action";
	}

}
