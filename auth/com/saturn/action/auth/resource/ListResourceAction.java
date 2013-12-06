package com.saturn.action.auth.resource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.BeanUtils;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.Resource;

public class ListResourceAction implements IAction {

	public String requestMapping() {
		return "/app/auth/resource/listResources.action";
	}
	
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		DataGridInfo dataGridInfo = new DataGridInfo(request);

		Resource resource = BeanUtils.getBean(request, Resource.class);

		ListData<Resource> data = Resource.getResources(resource, dataGridInfo.getStartPage(),
				dataGridInfo.getRows(), "sort",
				"asc");

		return new JsonView(JSONUtils.getDataGridJSON(data.getTotal(),
				data.getList()));
	}
}





