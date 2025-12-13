package com.zoedatalab.empleos.common.catalogs.exception;

public class WorkModeNotFoundException extends RuntimeException {

    public WorkModeNotFoundException() {
        super("WORK_MODE_NOT_FOUND");
    }
}
