package com.elex.newmq.exception;

public class NewMQStartUpException extends RuntimeException {

	static final long serialVersionUID = -1L;
	public NewMQStartUpException() {
        super();

    }


    public NewMQStartUpException(String message, Throwable cause) {
        super(message, cause);

    }


    public NewMQStartUpException(String message) {
        super(message);

    }


    public NewMQStartUpException(Throwable cause) {
        super(cause);

    }
}
