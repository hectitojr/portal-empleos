package com.zoedatalab.empleos.jobs.domain.exception;

import java.io.Serial;

public class CompanyIncompleteException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = 1L;

    public CompanyIncompleteException() {
        super("Company is inactive, suspended, or its profile is incomplete.");
    }
}
