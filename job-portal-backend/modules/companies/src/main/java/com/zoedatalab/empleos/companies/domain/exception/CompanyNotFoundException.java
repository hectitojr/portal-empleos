package com.zoedatalab.empleos.companies.domain.exception;

public class CompanyNotFoundException extends RuntimeException {

    public CompanyNotFoundException(){ super("COMPANY_NOT_FOUND");

    }
}

