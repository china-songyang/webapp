package com.saturn.action.webdo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.mobile.Meeting;

public class GetMeetingDetailAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {

		String json = request.getParameter("json");
		/*String json =	"{"
						+"\"command\":6008,"  //--接口标识
						+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
						+"\"param\" : {"
							+"\"userId\" : \"admin\","               
							+"\"meetingId\" : \"0\","               
							+"\"timeStamp\" : \"2013-07-04 15:20:00\","               
							+"\"msgCount\" : \"\","         //--手机使用的os版本，例如2.2或者4.1.2等
							+"\"order\" : \"1\""        
							+"}"
						+"}";*/
		
		
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();
		String status = "";
		String message = "";                     //--如果错误，返回错误结果
		
		String userId = jsonobject2.get("userId").toString();
		String meetingId = jsonobject2.get("meetingId").toString();
		String msgCount = jsonobject2.get("msgCount").toString();
		String order = jsonobject2.get("order").toString();
		
		String id = "0";
		if(meetingId!=null&&!"".equals(meetingId.trim())){
			id = meetingId;
		}
		
		Meeting vo = new Meeting();
		vo.setUserId(userId);
		vo.setId(id);
		
		String offset = "0";
		try {
			int count = Integer.parseInt(msgCount);
			if(count>0) {
				offset = ""+count;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		List<HashMap> resultList = Meeting.getMeetings(vo, "0", offset, order);
		List<Map<String, String>> returnList = new ArrayList<Map<String, String>>();
		if(resultList.isEmpty()){
			//密码不正确
			status = "F";
			message = "无信息";
		}else{
			status = "T";
			message = "有信息";
			for(Map map: resultList){
				String t_userId = ""+map.get("userName");
				String t_meetingId = ""+map.get("id");
				String t_meetingSubject = ""+map.get("title");
				String t_meetingContent = ""+map.get("text");
				String t_meetingTime = ""+map.get("time");
				String t_meetingPlace = ""+map.get("address");	//--用户名等级
				String t_meetingSendOrg = ""+map.get("unit");
				String t_createTime = ""+map.get("createTime");
				String t_fileUrl = ""+map.get("");
				JSONObject t_job = new JSONObject();
				t_job.put("userId", t_userId);
				t_job.put("meetingId", t_meetingId);
				t_job.put("meetingSubject", t_meetingSubject);
				t_job.put("meetingContent", t_meetingContent);
				t_job.put("meetingTime", t_meetingTime);
				t_job.put("meetingPlace", t_meetingPlace);
				t_job.put("meetingSendOrg", t_meetingSendOrg);
				t_job.put("createTime", t_createTime);
				t_job.put("fileUrl", t_fileUrl);
				returnList.add(t_job);
			}
		}
		
		JSONArray job = new JSONArray();
		job.addAll(returnList);
		
		Map map2 = new HashMap();
		map2.put("data", job);
		JSONObject job2 = new JSONObject();
		job2.putAll(map2);
		
		Map map3 = new HashMap();
		map3.put("command", command);
		map3.put("status", status);
		map3.put("message", message);
		map3.put("result", job2);
		
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
		//return new JsonView(ss);
		
	}
	@Override
	public String requestMapping() {
		return "/app/webdo/meeting/getMeetingDetail.do";
	}
}
