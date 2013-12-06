package com.saturn.action.webdo;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;
import com.saturn.app.web.view.JspView;

public class MobileAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String json = readJSONString(request);
		/*String json =	"{"
						+"\"command\":6005,"  //--接口标识
						+"\"platformType\":\"android\"," //--客户端的请求平台(ios或者android)
						+"\"param\" : {"
							+"\"username\" : \"yangrunjia\","               //--设备id
							+"\"password\" : \"yangrunjia\""         //--手机使用的os版本，例如2.2或者4.1.2等
							+"}"
						+"}";
		System.out.println(json);*/
		JSONObject jsonobject = JSONObject.fromObject(json);
		//JSONObject jsonobject2 = JSONObject.fromObject(jsonobject.get("param"));
		
		String command = jsonobject.get("command").toString();
		if("6001".equals(command)) {
			return new JspView("/app/webdo/apkfile/getTest.do?json="+json);
		} else if("6002".equals(command)) {
			return new JspView("/app/webdo/message/getMessage.do?json="+json);
		} else if("6005".equals(command)) {
			return new JspView("/app/webdo/user/getUser.do?json="+json);
		} else if("6003".equals(command)) {
			return new JspView("/app/webdo/news/getNews.do?json="+json);
		} else if("6004".equals(command)) {
			return new JspView("/app/webdo/news/getNewsDetail.do?json="+json);
		} else if("6006".equals(command)) {
			return new JspView("/app/webdo/users/getUsers.do?json="+json);
		} else if("6007".equals(command)) {
			return new JspView("/app/webdo/meeting/sendMeeting.do?json="+json);
		} else if("6008".equals(command)) {
			return new JspView("/app/webdo/meeting/getMeetingDetail.do?json="+json);
		}
		return null;
	}
	private String readJSONString(HttpServletRequest request) {
		StringBuffer json = new StringBuffer();
		String line = null;
		try {
			BufferedReader reader = request.getReader();
			
			while ((line = reader.readLine())!=null) {
				json.append(line);
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return json.toString();
	}
	@Override
	public String requestMapping() {
		return "/app/webdo/sys/mobile.do";
	}
}


