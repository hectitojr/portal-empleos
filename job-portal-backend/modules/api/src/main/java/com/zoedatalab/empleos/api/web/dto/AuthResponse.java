package com.zoedatalab.empleos.api.web.dto;

public record AuthResponse(
        String tokenType,
        String accessToken,
        long expiresIn,
        String refreshToken
) {}
