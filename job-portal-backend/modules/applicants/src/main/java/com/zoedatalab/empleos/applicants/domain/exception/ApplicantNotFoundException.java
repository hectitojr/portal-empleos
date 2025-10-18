package com.zoedatalab.empleos.applicants.domain.exception;

public class ApplicantNotFoundException extends RuntimeException {
    public ApplicantNotFoundException() {
        super("APPLICANT_NOT_FOUND");
    }
}
