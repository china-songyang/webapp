package com.saturn.action.auth.organization;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.User;

public class ListOrganizationUserAction implements IAction {

	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		DataGridInfo dataGridInfo = new DataGridInfo(request);
		
		String organizationId = request.getParameter("organizationId");
	 
		ListData<User> data = User.getUsersByOrganizationId(organizationId, dataGridInfo.getStartPage(),
				dataGridInfo.getRows(), dataGridInfo.getSortId());
	 
		return new JsonView(JSONUtils.getDataGridJSON(data.getTotal(),
				data.getList()));
	}

	public String requestMapping() {
		return "/app/auth/organization/listOrganizationUser.action";
	}

}
