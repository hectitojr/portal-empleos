package com.zoedatalab.empleos.applications.domain.exception;

public class ApplicationNotFoundException extends RuntimeException {
    public ApplicationNotFoundException() { super("APPLICATION_NOT_FOUND"); }
}