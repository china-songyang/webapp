package com.saturn.app.exception;

/**
 * Business Service Exception
 * 
 * @author Administrator
 * 
 */
public class BSException extends RuntimeException {

	private static final long serialVersionUID = 3651592741030852704L;

	public BSException() {
		super();
	}

	public BSException(String message, Throwable cause) {
		super(message, cause);
	}

	public BSException(String message) {
		super(message);
	}

	public BSException(Throwable cause) {
		super(cause);
	}

}
