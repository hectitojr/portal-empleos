package com.zoedatalab.empleos.iam.application.exception;

public class TokenInvalidException extends RuntimeException {
    public TokenInvalidException() { super("TOKEN_INVALID"); }
}
