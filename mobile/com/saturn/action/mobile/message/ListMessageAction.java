package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.db.ListData;
import com.saturn.app.utils.JSONUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.easyui.DataGridInfo;
import com.saturn.app.web.view.JsonView;
import com.saturn.mobile.MobileMessage;

public class ListMessageAction implements IAction {
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		DataGridInfo dataGridInfo = new DataGridInfo(request);

		MobileMessage mm = new MobileMessage(null,
				request.getParameter("title"), request.getParameter("text"),
				null, request.getParameter("statename"),
				request.getParameter("createtime"), null,
				request.getParameter("creatername"), null, null, null, null,
				null);

		String type = request.getParameter("type");
		mm.setType(type);
		ListData<MobileMessage> data = MobileMessage.getMessages(mm,
				dataGridInfo.getStartPage(), dataGridInfo.getRows(),
				dataGridInfo.getSortId(), dataGridInfo.getOreder());
		return new JsonView(JSONUtils.getDataGridJSON(data.getTotal(),
				data.getList()));
	}

	@Override
	public String requestMapping() {
		return "/mobile/message/listMessage.action";
	}
}
