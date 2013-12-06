package com.saturn.action.webdo;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.saturn.app.utils.CodeUtils;
import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.auth.User;

public class GetUserAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		//String json = readJSONString(request);
		String json = request.getParameter("json");
		/*String json =	"{"
						+"\"command\":6005,"  //--接口标识
						+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
						+"\"param\" : {"
							+"\"username\" : \"yangrunjia\","               //--设备id
							+"\"password\" : \"yangrunjia\""         //--手机使用的os版本，例如2.2或者4.1.2等
							+"}"
						+"}";*/
		/*System.out.println(json);*/
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command = jsonobject.get("command").toString();
		String platformType = jsonobject.get("platformType").toString();
		String status = "";
		String message = "";                     //--如果错误，返回错误结果
		
		String username = jsonobject2.get("username").toString();
		String password = jsonobject2.get("password").toString();
		String level = "";	//--用户名等级
		String userId = "";
		
		password = CodeUtils.encode(password);
		User user = User.get(username);
		if (user != null) {
			if (user.getPassword().equals(password)) {
				status = "T";
				message = "用户正确";
				username = user.getName();
				level = user.getLevel();
				userId = user.getId();
			} else {
				//密码不正确
				status = "F";
				message = "密码不正确";
			}
		} else {
			//用户不存在
			status = "F";
			message = "用户不存在";
		}
		
		
		
		Map map1 = new HashMap();
		map1.put("username", username);
		map1.put("level", level);
		map1.put("userId", userId);
		JSONObject job = new JSONObject();
		job.putAll(map1);
		
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
//			response.setContentType("text/x-json; charset=UTF-8");
			//String aa = "{\"message\":\"有更新\",\"result\":{\"data\":{\"content\":\"apk2\",\"downloadUrl\":\"http://localhost:8088/webapp/app/system/upload/download.do?note=/webapp/attached/file/20130627/20130627145035_954.apk\"}},\"status\":\"T\",\"command\":\"6001\"}";
			//System.out.println(aa.getBytes().length+"--"+ss.getBytes().length+"--"+ss.length());
			//response.setHeader("Content-Length", ""+ss.getBytes().length);
			//response.setHeader("Encoding-Type", "UTF-8");
			//response.setBufferSize(402800);
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
	private String readJSONString(HttpServletRequest request) {
		StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			
			while ((line = reader.readLine())!=null) {
				System.out.println(line);
				json.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return json.toString();
	}
	@Override
	public String requestMapping() {
		return "/app/webdo/user/getUser.do";
	}
}


