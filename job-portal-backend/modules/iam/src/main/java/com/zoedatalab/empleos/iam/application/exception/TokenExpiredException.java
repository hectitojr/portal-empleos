package com.zoedatalab.empleos.iam.application.exception;

public class TokenExpiredException extends RuntimeException {
    public TokenExpiredException() { super("TOKEN_EXPIRED"); }
}
