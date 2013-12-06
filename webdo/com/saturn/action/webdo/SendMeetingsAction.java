package com.saturn.action.webdo;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.mobile.Meeting;

public class SendMeetingsAction implements IAction {
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String json = request.getParameter("json");
		
		 /* String json = "{" +"\"command\":6007," //--接口标识
		  +"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
		  +"\"param\" : {" +"\"userId\" : \"admin\","
		  +"\"meetingSubject\" : \"开会啦开会啦\","
		  +"\"meetingTime\" : \"2013年8月10日下午3点\","
		  +"\"meetingPlace\" : \"宽城区政府2楼会议室\","
		  +"\"meetingMember\" : \"songyang;yonghu;ceshi;admin\","
		  +"\"meetingSendOrg\" : \"宽城区政府办公室\","
		  +"\"meetingContent\" : \"研讨政府机关下发信息化建设方案实施\","
		  +"\"createTime\" : \"2013-08-10 10:00:00\"" +"}" +"}";*/
		 

		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));

		String command = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();

		String status = "";
		String message = "";
		String userId = jsonobject2.get("userId").toString();
		String meetingSubject = jsonobject2.get("meetingSubject").toString();
		String meetingTime = jsonobject2.get("meetingTime").toString();
		String meetingPlace = jsonobject2.get("meetingPlace").toString();
		String meetingMember = jsonobject2.get("meetingMember").toString();
		String meetingSendOrg = jsonobject2.get("meetingSendOrg").toString();
		String meetingContent = jsonobject2.get("meetingContent").toString();
		String createTime = jsonobject2.get("createTime").toString();

		/*
		 * String[] userStr = meetingMember.split(";"); String point = "";
		 * String userName = ""; for(int i=0; i<userStr.length; i++) { String[]
		 * useri = userStr[i].split("_"); for(int y=0; y<useri.length; y++) {
		 * if(0 == y){ point += useri[0] + ","; } else{ userName += useri[1] +
		 * ","; } } }
		 */

		Meeting vo = new Meeting();
		vo.setUserId(userId);
		vo.setTitle(meetingSubject);
		vo.setTime(meetingTime);
		vo.setAddress(meetingPlace);
		vo.setUnit(meetingSendOrg);
		vo.setText(meetingContent);
		vo.setCreateTime(createTime);
		vo.setState("visible.true");
		vo.setStateName("显示");

		Meeting.add(vo);

		Meeting meeting = Meeting.getMaxId();
		String meetingId = meeting.getId();

		// String[] points = point.split(",");

		String[] memberStr = meetingMember.split(";");

		for (int i = 0; i < memberStr.length; i++) {
			if (Meeting.addUserToMeeting(memberStr[i], meetingId, createTime) == 1) {
				// 密码不正确
				status = "T";
				message = "成功";
			} else {
				status = "T";
				message = "失败";
			}
		}
		
		Map map3 = new HashMap();
		map3.put("command", command);
		map3.put("status", status);
		map3.put("message", message);

		JSONObject job3 = new JSONObject();
		job3.putAll(map3);

		String ss = job3.toString();

		try {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(ss);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.flushBuffer();
			} catch (IOException ie) {
				ie.printStackTrace();
			}
		}
		return null;
	}

	@Override
	public String requestMapping() {
		return "/app/webdo/meeting/sendMeeting.do";
	}
}
