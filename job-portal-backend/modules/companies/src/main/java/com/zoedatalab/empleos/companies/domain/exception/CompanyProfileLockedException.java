package com.zoedatalab.empleos.companies.domain.exception;

import java.io.Serial;

public class CompanyProfileLockedException extends RuntimeException {

    @Serial
    private static final long serialVersionUID = 1L;

    public CompanyProfileLockedException() {
        super("No se puede borrar el perfil de la empresa porque existen empleos.");
    }
}
