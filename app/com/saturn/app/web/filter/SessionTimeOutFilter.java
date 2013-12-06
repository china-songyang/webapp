package com.saturn.app.web.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class SessionTimeOutFilter implements Filter {

	public void destroy() {
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {

		HttpServletRequest httpRequest = (HttpServletRequest) request;
		HttpServletResponse httpResponse = (HttpServletResponse) response;
		Object authUser = httpRequest.getSession().getAttribute("authUser");

//		String loginAction = ((HttpServletRequest) request).getRequestURI();
//		loginAction = loginAction.substring(1);
//		loginAction = loginAction.substring(loginAction.indexOf("/"));

		if (authUser == null
			//	&& !"/app/auth/user/login.action".equals(loginAction)
				) {

			request.getRequestDispatcher("/app/login.jsp").forward(
					httpRequest, httpResponse);
		} else {
			chain.doFilter(request, response);
		}
	}

	public void init(FilterConfig config) throws ServletException {
	}
}
