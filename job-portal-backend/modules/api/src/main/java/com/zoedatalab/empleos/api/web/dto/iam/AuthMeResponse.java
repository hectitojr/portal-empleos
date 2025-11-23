package com.zoedatalab.empleos.api.web.dto.iam;

public record AuthMeResponse(
        String id,
        String email,
        String role
) {}
