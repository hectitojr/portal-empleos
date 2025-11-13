package com.zoedatalab.empleos.api.web.dto.common;

import java.time.OffsetDateTime;

public record MessageResponse(
        String code,        
        String message,    
        String traceId,     
        OffsetDateTime timestamp
) {}
