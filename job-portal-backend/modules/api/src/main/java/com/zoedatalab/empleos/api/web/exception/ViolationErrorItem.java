package com.zoedatalab.empleos.api.web.exception;

public record ViolationErrorItem(
        String param,
        String code,
        String message
) { }
