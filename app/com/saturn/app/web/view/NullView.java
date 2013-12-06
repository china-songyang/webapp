package com.saturn.app.web.view;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IView;

public class NullView implements IView {


	public NullView() {
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {
		
	}
}
