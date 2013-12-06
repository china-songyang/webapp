package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.auth.User;
import com.saturn.mobile.Meeting;

public class ListMetHaveMetIdAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		DataGridInfo dataGridInfo = new DataGridInfo(request);
		String metId = request.getParameter("metId");
		Meeting.getUserReMet(metId);
		ListData<User> data = User.getUsersWithoutByMetId(metId, dataGridInfo.getStartPage(),
				dataGridInfo.getRows(), dataGridInfo.getSortId());
	 
		return new JsonView(JSONUtils.getDataGridJSON(data.getTotal(),
				data.getList()));
	}
	@Override
	public String requestMapping() {
		return "/app/mobile/meeting/listMetHaveMetId.action";
	}
}
