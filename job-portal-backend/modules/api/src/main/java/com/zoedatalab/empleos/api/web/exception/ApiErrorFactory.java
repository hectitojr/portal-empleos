package com.zoedatalab.empleos.api.web.exception;

import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.MDC;

import java.time.Instant;
import java.util.List;

final class ApiErrorFactory {

    static ApiErrorResponse build(HttpServletRequest req,
                                  ApiErrorCode code,
                                  List<FieldErrorItem> fields,
                                  List<ViolationErrorItem> violations) {
        String traceId = MDC.get("traceId");
        String path = (req != null) ? req.getRequestURI() : null;

        return new ApiErrorResponse(
                code.name(),
                code.defaultMessage,
                code.status.value(),
                path,
                traceId,
                Instant.now(),
                (fields == null || fields.isEmpty()) ? null : fields,
                (violations == null || violations.isEmpty()) ? null : violations
        );
    }

    private ApiErrorFactory() {}
}
