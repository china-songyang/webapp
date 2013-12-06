package com.saturn.action.mobile.meeting;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.mobile.Meeting;

public class ListMeetingsAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		DataGridInfo dataGridInfo = new DataGridInfo(request);

		Meeting mt = new Meeting(null,
				request.getParameter("userId"),request.getParameter("title"),
				request.getParameter("time"), request.getParameter("address"),
				request.getParameter("unit"), null,null, null,null);

		ListData<Meeting> data = Meeting.getMeetings(mt,
				dataGridInfo.getStartPage(), dataGridInfo.getRows(),
				dataGridInfo.getSortId(), dataGridInfo.getOreder());
		return new JsonView(JSONUtils.getDataGridJSON(data.getTotal(),
				data.getList()));
	}
	
	@Override
	public String requestMapping() {
		return "/app/mobile/meeting/listMeetings.action";
	}
}
