package com.zoedatalab.empleos.companies.domain.exception;

public class TaxIdAlreadyExistsException extends RuntimeException {

    public TaxIdAlreadyExistsException(){
        super("COMPANY_TAX_ID_ALREADY_EXISTS");
    }
}

