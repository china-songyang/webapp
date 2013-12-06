package com.saturn.action.webdo;

import java.io.BufferedReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JsonView;
import com.saturn.webdo.MobileBase;

public class GetTestAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		//String json = readJSONString(request);
		String json = request.getParameter("json");
		/*String json =	"{"
						+"\"command\":6001,"  //--接口标识
						+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
						+"\"param\" : {"
							+"\"deviceId\" : \"355031\","               //--设备id
							+"\"osVersion\" : \"4.1.2\","         //--手机使用的os版本，例如2.2或者4.1.2等
							+"\"softVersion\" : 1,"         //--OA应用软件运行的版本号（用于跟服务器的应用软件版本号比较）
							+"\"mobileType\" : \"LG\""       //--手机型号（LG、HTC...）
							+"}"
						+"}";*/
		//System.out.println(json);
		JSONObject jsonobject = JSONObject.fromObject(json);
		JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		MobileBase vo = new MobileBase(null
				, jsonobject.get("command").toString()
				, jsonobject.get("platformType").toString()
				, jsonobject2.get("deviceId").toString()
				, jsonobject2.get("osVersion").toString()
				, jsonobject2.get("mobileType").toString()
				, jsonobject2.get("softVersion").toString()
				);
		
		String downurl = request.getRequestURL().toString();
		String[] urls = downurl.split("/");
		if(urls.length>=3)
			downurl = "http://"+urls[2]+"/"+urls[3]+"/app/system/upload/download.do?note=";
		else
			downurl="http://";
		
		Map map = MobileBase.addOrEdit(vo, downurl);
		
		Map map1 = new HashMap();
		map1.put("downloadUrl", map.get("downloadUrl"));
		map1.put("content", map.get("content"));
		JSONObject job = new JSONObject();
		job.putAll(map1);
		
		Map map2 = new HashMap();
		map2.put("data", job);
		JSONObject job2 = new JSONObject();
		job2.putAll(map2);
		
		Map map3 = new HashMap();
		map3.put("command", map.get("command"));
		map3.put("status", map.get("status"));
		map3.put("message", map.get("message"));
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
		// TODO Auto-generated method stub
		StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			while ((line = reader.readLine())!=null) {
				json.append(line);
			}
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return json.toString();
	}
	@Override
	public String requestMapping() {
		return "/app/webdo/apkfile/getTest.do";
	}
}


