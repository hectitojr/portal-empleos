package com.zoedatalab.empleos.common.catalogs.exception;

public class AreaNotFoundException extends RuntimeException {

    public AreaNotFoundException() {
        super("AREA_NOT_FOUND");
    }
}
