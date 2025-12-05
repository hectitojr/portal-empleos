package com.zoedatalab.empleos.api.web.common.dto;

import java.time.OffsetDateTime;

public record MessageResponse(
        String code,
        String message,
        String traceId,
        OffsetDateTime timestamp
) {
}
