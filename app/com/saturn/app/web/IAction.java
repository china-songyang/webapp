package com.saturn.app.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface IAction {
	
	public abstract IView execute(HttpServletRequest request, HttpServletResponse response);

	public abstract String requestMapping();
}	
