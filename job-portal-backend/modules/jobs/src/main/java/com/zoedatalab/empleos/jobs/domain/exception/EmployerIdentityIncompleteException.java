package com.zoedatalab.empleos.jobs.domain.exception;

import java.io.Serial;

public class EmployerIdentityIncompleteException extends RuntimeException {
    @Serial
    private static final long serialVersionUID = 1L;

    public EmployerIdentityIncompleteException() {
        super("Employer identity is incomplete.");
    }
}
