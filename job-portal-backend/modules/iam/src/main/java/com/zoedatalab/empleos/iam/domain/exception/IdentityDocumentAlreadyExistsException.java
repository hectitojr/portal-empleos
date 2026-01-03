package com.zoedatalab.empleos.iam.domain.exception;

public class IdentityDocumentAlreadyExistsException extends RuntimeException {
    public IdentityDocumentAlreadyExistsException() {
        super("Identity document already exists.");
    }
}
