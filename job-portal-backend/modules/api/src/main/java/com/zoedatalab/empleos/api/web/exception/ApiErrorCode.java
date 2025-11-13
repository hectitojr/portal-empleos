package com.zoedatalab.empleos.api.web.exception;

import org.springframework.http.HttpStatus;

public enum ApiErrorCode {

    // IAM
    EMAIL_EXISTS(HttpStatus.CONFLICT, "El correo ya está registrado."),
    BAD_CREDENTIALS(HttpStatus.UNAUTHORIZED, "Credenciales inválidas."),
    USER_SUSPENDED(HttpStatus.UNAUTHORIZED, "La cuenta está suspendida."),
    TOKEN_INVALID(HttpStatus.UNAUTHORIZED, "Token inválido."),
    TOKEN_EXPIRED(HttpStatus.UNAUTHORIZED, "El token ha expirado."),
    UNAUTHENTICATED(HttpStatus.UNAUTHORIZED, "No autenticado."),
    RESET_TOKEN_INVALID(HttpStatus.UNAUTHORIZED, "El enlace de restablecimiento no es válido."),
    RESET_TOKEN_EXPIRED(HttpStatus.UNAUTHORIZED, "El enlace de restablecimiento ha expirado."),

    // Autorización
    FORBIDDEN(HttpStatus.FORBIDDEN, "Acceso no permitido."),

    // Companies
    COMPANY_NOT_FOUND(HttpStatus.NOT_FOUND, "La empresa no existe."),
    COMPANY_TAX_ID_ALREADY_EXISTS(HttpStatus.CONFLICT, "El RUC ya está asociado a otra cuenta."),
    DISTRICT_NOT_FOUND(HttpStatus.BAD_REQUEST, "El distrito no existe."),
    COMPANY_INCOMPLETE(HttpStatus.BAD_REQUEST, "Completa la ficha de empresa."),

    // Applicants
    APPLICANT_NOT_FOUND(HttpStatus.NOT_FOUND, "El postulante no existe."),

    // Jobs
    JOB_NOT_FOUND(HttpStatus.NOT_FOUND, "La oferta no existe."),
    JOB_CLOSED(HttpStatus.CONFLICT, "La oferta está cerrada."),

    // Applications
    APPLICATION_NOT_FOUND(HttpStatus.NOT_FOUND, "La postulación no existe."),
    DUPLICATE_APPLICATION(HttpStatus.CONFLICT, "Ya postulaste a esta oferta."),
    APPLICANT_INCOMPLETE(HttpStatus.BAD_REQUEST, "Completa tu perfil de postulante."),

    // Validación / framework
    VALIDATION_ERROR(HttpStatus.BAD_REQUEST, "Error de validación."),
    CONSTRAINT_VIOLATION(HttpStatus.BAD_REQUEST, "Parámetros inválidos."),
    MALFORMED_JSON(HttpStatus.BAD_REQUEST, "JSON mal formado."),
    MISSING_PARAMETER(HttpStatus.BAD_REQUEST, "Falta un parámetro obligatorio."),
    TYPE_MISMATCH(HttpStatus.BAD_REQUEST, "Tipo de dato inválido."),
    UNSUPPORTED_MEDIA_TYPE(HttpStatus.UNSUPPORTED_MEDIA_TYPE, "Tipo de contenido no soportado."),
    DATA_INTEGRITY_VIOLATION(HttpStatus.CONFLICT, "Violación de integridad de datos."),

    // Fallback
    INTERNAL_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "Ocurrió un error inesperado.");

    public final HttpStatus status;
    public final String defaultMessage;

    ApiErrorCode(HttpStatus status, String defaultMessage) {
        this.status = status;
        this.defaultMessage = defaultMessage;
    }
}
