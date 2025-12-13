package com.zoedatalab.empleos.common.catalogs.exception;

public class EmploymentTypeNotFoundException extends RuntimeException {

    public EmploymentTypeNotFoundException() {
        super("EMPLOYMENT_TYPE_NOT_FOUND");
    }
}
