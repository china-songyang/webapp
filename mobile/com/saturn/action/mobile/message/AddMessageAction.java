package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class AddMessageAction implements IAction {
	@Override
	public IView execute(HttpServletRequest request,HttpServletResponse response) {
		MobileMessage vo = BeanUtils.getBean(request, MobileMessage.class);
		String level = request.getParameter("level");
		if ("2".equals(level)) {
			vo.setLevelname("重要");
		} else if ("1".equals(level)) {
			vo.setLevelname("普通");
		}
		String type = vo.getType();
		MobileMessage mm = MobileMessage.getOne(type);

		if (mm.getPoint() == null || "".equals(mm.getPoint())) {
			vo.setPoint("1");
		} else {
			String point = "" + (Integer.parseInt(mm.getPoint()) + 1);
			vo.setPoint(point);
		}
		if (MobileMessage.add(vo) == 1) {
			if("1".equals(type)){
				return new JspView("/app/mobile/office/message/show.jsp");
			} else if("2".equals(type)) {
				return new JspView("/app/mobile/office/meeting/show.jsp");
			}
			
		} else {
			return new JspErrorView("添加信息失败！");
		}
		return null;
	}

	@Override
	public String requestMapping() {
		return "/mobile/message/addMessage.action";
	}
}
