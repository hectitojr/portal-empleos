package com.zoedatalab.empleos.api.web.exception;

import java.time.Instant;
import java.util.List;

public record ApiErrorResponse(
        String error,                 // código estable p/ front: p.ej. EMAIL_EXISTS
        String message,               // mensaje entendible
        int status,                   // 409, 401, 403, 404...
        String path,                  // URI del request
        String traceId,               // correlación (MDC) si existiera
        Instant timestamp,            // ISO-8601
        List<FieldErrorItem> fieldErrors,     // errores de @Valid body
        List<ViolationErrorItem> violations   // errores de @Validated params
) {
}
