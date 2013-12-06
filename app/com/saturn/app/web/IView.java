package com.saturn.app.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.view.JspView;
import com.saturn.app.web.view.StreamView;
import com.saturn.app.web.view.XmlView;

/**
 * 定义了视图类型的操作接口。视图对象是展现组件运行的结果，是对用户请求的响应结果。
 * 在展现组件中被调用的视图结点负责创建视图类型的具体实现类的对象。视图类型的具体实现类通过执行dispather方法可以将响应数据展现给用户。
 * <p>一共有三种具体的视图分别实现了这个接口，分别是<code>JspView</code>、<code>StreamView</code>、<code>XmlView</code>
 * 
 * @author 谷钰
 * 
 * @version 1.0 2008.8.28
 * 
 * @see JspView
 * @see StreamView
 * @see XmlView
 * 
 */
public interface IView {

	/**
	 * 将用户的操作结果展现给用户的过程
	 * 
	 * @param request
	 * @param response
	 */
	public abstract void dispather(HttpServletRequest request,
			HttpServletResponse response);

}