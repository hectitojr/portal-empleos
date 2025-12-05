package com.zoedatalab.empleos.api.web.iam.dto;

public record AuthMeResponse(
        String id,
        String email,
        String role
) {
}
