package com.saturn.app.web.view;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IView;

/**
 * Json类型视图的实现类，保存了用于响应用户操作的Json字符类型的数据。
 * 
 * @author 谷钰
 * 
 * @version 1.0 2008.8.28
 * 
 * @see IView
 * @see HttpServletRequest
 * @see HttpServletResponse
 * 
 */
public class JsonView implements IView {

	private String jsonData = null;

	public JsonView(String jsonData) {
		this.jsonData = jsonData;
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {

		try {
//			response.setContentType("text/x-json; charset=UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().write(this.jsonData);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				response.flushBuffer();
			} catch (IOException ie) {
				ie.printStackTrace();
			}
		}
	}
}
