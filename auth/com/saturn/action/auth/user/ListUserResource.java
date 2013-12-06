package com.saturn.action.auth.user;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.Resource;

public class ListUserResource implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String userId = request.getParameter("userId");
	 
		List<Resource> data = Resource.getResourcesByUserId(userId);
	 
		return new JsonView(JSONUtils.getDataGridJSON(0,data));
	}

	public String requestMapping() {
		return "/app/auth/user/listUserResource.action";
	}

}
