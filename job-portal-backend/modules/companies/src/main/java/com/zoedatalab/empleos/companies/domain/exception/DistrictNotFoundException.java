package com.zoedatalab.empleos.companies.domain.exception;

public class DistrictNotFoundException extends RuntimeException {
    public DistrictNotFoundException() { super("DISTRICT_NOT_FOUND"); }
}
