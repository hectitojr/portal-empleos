package com.zoedatalab.empleos.applications.domain.exception;

public class DuplicateApplicationException extends RuntimeException {
    public DuplicateApplicationException() { super("DUPLICATE_APPLICATION"); }
}