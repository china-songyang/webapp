package com.saturn.app.exception;

public class DBException extends RuntimeException {

	private static final long serialVersionUID = 3093604495966748002L;

	public DBException(String message, Throwable cause) {
		super(message, cause);
	}

	public DBException(String message) {
		super(message);
	}

	public DBException(Throwable cause) {
		super(cause);
	}
}
