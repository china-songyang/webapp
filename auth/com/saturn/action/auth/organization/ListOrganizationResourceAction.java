package com.saturn.action.auth.organization;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.Resource;

public class ListOrganizationResourceAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String organizationId = request.getParameter("organizationId");

		List<Resource> resources = Resource
				.getResourcesByOrganizationId(organizationId);

		return new JsonView(JSONUtils.getDataGridJSON(0, resources));
	}

	public String requestMapping() {
		return "/app/auth/organization/listOrganizationResource.action";
	}

}
