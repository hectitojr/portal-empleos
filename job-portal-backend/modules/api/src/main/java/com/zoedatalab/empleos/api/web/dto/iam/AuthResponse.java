package com.zoedatalab.empleos.api.web.dto.iam;

public record AuthResponse(
        String tokenType,
        String accessToken,
        long expiresIn,
        String refreshToken
) {}
