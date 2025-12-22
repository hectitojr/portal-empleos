package com.zoedatalab.empleos.api.web.exception;

import java.time.Instant;
import java.util.List;

public record ApiErrorResponse(
        String error,
        String message,
        int status,
        String path,
        String traceId,
        Instant timestamp,
        List<FieldErrorItem> fieldErrors,
        List<ViolationErrorItem> violations
) {
}
