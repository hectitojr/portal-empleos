package com.zoedatalab.empleos.jobs.domain.exception;

public class ApplicantNotFoundException extends RuntimeException {
    public ApplicantNotFoundException() {
        super("APPLICANT_NOT_FOUND");
    }
}
