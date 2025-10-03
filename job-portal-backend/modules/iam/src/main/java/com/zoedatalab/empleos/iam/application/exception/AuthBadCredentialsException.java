package com.zoedatalab.empleos.iam.application.exception;

public class AuthBadCredentialsException extends RuntimeException {
    public AuthBadCredentialsException() { super("BAD_CREDENTIALS"); }
}
