package com.zoedatalab.empleos.iam.application.dto;

import lombok.*;

@Getter @Builder @AllArgsConstructor @NoArgsConstructor
public class AuthTokens {
    private String tokenType;     // "Bearer"
    private String accessToken;   // JWT
    private long   expiresIn;     // seg
    private String refreshToken;  // random persisted
}
