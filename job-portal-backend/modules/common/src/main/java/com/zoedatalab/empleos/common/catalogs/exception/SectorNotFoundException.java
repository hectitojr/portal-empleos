package com.zoedatalab.empleos.common.catalogs.exception;

public class SectorNotFoundException extends RuntimeException {

    public SectorNotFoundException() {
        super("SECTOR_NOT_FOUND");
    }
}
