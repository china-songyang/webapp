package com.saturn.app.web.view;

import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IView;

/**
 * JSP类型视图的实现类，记录了视图要呈现给用户的响应jsp页面，通过<code>dispather</code>方法实现jsp页面的显示。
 * <p>字段url：记录了视图要呈现给用户的响应jsp页面的路径。url的写法是从web上下文的根目录“/”开始的相对路径。
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
public class JspView implements IView {

	private String url = null;
	
	public JspView(String url) {
		this.url = url;
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {
		
		try {
			RequestDispatcher dispatcher = request.getRequestDispatcher(url.trim());
			dispatcher.forward(request, response);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
