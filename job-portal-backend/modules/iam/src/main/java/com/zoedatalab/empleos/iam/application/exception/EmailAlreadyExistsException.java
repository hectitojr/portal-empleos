package com.zoedatalab.empleos.iam.application.exception;

public class EmailAlreadyExistsException extends RuntimeException {
    public EmailAlreadyExistsException() { super("EMAIL_EXISTS"); }
}
