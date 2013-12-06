package com.saturn.action.mobile.message;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.utils.BeanUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspErrorView;
import com.saturn.app.web.view.JspView;
import com.saturn.mobile.MobileMessage;

public class UpdateMessageAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		MobileMessage vo = BeanUtils.getBean(request, MobileMessage.class);
		
		String level = request.getParameter("level");
		if("mobile.message.state.important".equals(level)) {
			vo.setLevelname("重要");
		} else {
			vo.setLevelname("普通");
		}
		if(MobileMessage.edit(vo) == 1) {
			return new JspView("/app/mobile/office/message/show.jsp");
		} else {
			return new JspErrorView("修改信息失败");
		}
	}
	@Override
	public String requestMapping() {
		// TODO Auto-generated method stub
		return "/app/mobile/office/message/update.action";
	}
}
