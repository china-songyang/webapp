package com.saturn.app.web.view;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IView;

/**
 * xml类型视图的实现类，保存了用于响应用户操作的xml字符类型的数据。
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
public class XmlView implements IView {

	private String xmlData = null;

	public XmlView(String xmlData) {
		this.xmlData = xmlData;
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {

		try {
			response.setContentType("text/xml; charset=UTF-8");
			response.getWriter().write(this.xmlData);
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
