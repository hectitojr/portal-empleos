package com.zoedatalab.empleos.iam.application.exception;

public class UserSuspendedException extends RuntimeException {
    public UserSuspendedException() { super("USER_SUSPENDED"); }
}
