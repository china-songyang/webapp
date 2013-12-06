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
import com.saturn.auth.User;

public class GetUsersAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		
		String json =request.getParameter("json");
		/*String json =	"{"
		+"\"command\":6006,"  //--接口标识
		+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
		+"\"param\" : {"
			+"\"anchorId\" : \"0\""      
			+"}"
		+"}";*/
		
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command  = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();
		
		String status = "";
		String message = "";
		String anchorId = jsonobject2.get("anchorId").toString();
		
		User vo = new User();
		vo.setPoint(anchorId);
		
		String offset = "0";
		
		List<HashMap> resultList = User.getUserByPoint(vo, "0", offset);
		System.out.println(resultList);
		List<Map<String, String>> returnList = new ArrayList<Map<String, String>>();
		if(resultList.isEmpty()){
			//密码不正确
			status = "F";
			message = "无信息";
		}else{
			status = "T";
			message = "有信息";
			
			for(Map map: resultList){
				String t_userName = ""+map.get("name");
				String t_userId = ""+map.get("id");
				String t_anchorId = ""+map.get("point");
				String t_unit = ""+map.get("unit");
				String t_department = ""+map.get("department");
				String t_rank = ""+map.get("post");
				String t_officePhone = ""+map.get("tel");
				String t_mobile = ""+map.get("phone");
				String t_fax = ""+map.get("fax");
				String t_email = ""+map.get("email");
				JSONObject t_job = new JSONObject();
				t_job.put("userName", t_userName);
				t_job.put("userId", t_userId);
				t_job.put("anchorId", t_anchorId);
				t_job.put("unit", t_unit);
				t_job.put("department", t_department);
				t_job.put("rank", t_rank);
				t_job.put("officePhone", t_officePhone);
				t_job.put("mobile", t_mobile);
				t_job.put("fax", t_fax);
				t_job.put("email", t_email);
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
	}
	
	@Override
	public String requestMapping() {
		return "/app/webdo/users/getUsers.do";
	}
}
