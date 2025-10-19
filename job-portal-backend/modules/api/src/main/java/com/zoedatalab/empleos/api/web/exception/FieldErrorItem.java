package com.zoedatalab.empleos.api.web.exception;

public record FieldErrorItem(
        String field,
        String code,
        String message
) { }
