package com.saturn.action.website.apkfile;

import java.io.BufferedReader;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IAction;
import com.saturn.app.web.IView;

public class GetTestAction implements IAction{
	@Override
	public IView execute(HttpServletRequest request,
			HttpServletResponse response) {
		String json = readJSONString(request);
		System.out.println(json);
		return null;
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
		return "/app/website/apkfile/getTest.do";
	}
}


