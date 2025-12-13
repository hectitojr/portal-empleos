package com.zoedatalab.empleos.common.catalogs.exception;

public class DistrictNotFoundException extends RuntimeException {

    public DistrictNotFoundException() {
        super("DISTRICT_NOT_FOUND");
    }
}
