package com.saturn.action.auth.role;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.Resource;

public class ListRoleResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String roleId = request.getParameter("roleId");

		List<Resource> resources = Resource.getResourcesByRoleId(roleId);

		return new JsonView(JSONUtils.getDataGridJSON(0, resources));
	}

	public String requestMapping() {
		return "/app/auth/role/listRoleResource.action";
	}

}
