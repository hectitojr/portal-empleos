package com.zoedatalab.empleos.iam.application.exception;

public class ResetTokenExpiredException extends RuntimeException {
    public ResetTokenExpiredException() { super("RESET_TOKEN_EXPIRED"); }
}
