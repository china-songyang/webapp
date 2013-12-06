package com.saturn.app.web.view;

import java.io.IOException;
import java.io.ObjectOutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.saturn.app.web.IView;

public class ObjectStreamView implements IView {

	private Object object;
	
	private String contentType;

	public ObjectStreamView(Object object, String contentType) {
		super();
		this.object = object;
		this.contentType = contentType;
	}

	public void dispather(HttpServletRequest request,
			HttpServletResponse response) {
		
		response.setContentType(this.contentType);
		
		ServletOutputStream ouputStream = null;
		ObjectOutputStream oos = null;
		try {
			ouputStream = response.getOutputStream();
			oos = new ObjectOutputStream(ouputStream);
			oos.writeObject(this.object);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				oos.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}
}