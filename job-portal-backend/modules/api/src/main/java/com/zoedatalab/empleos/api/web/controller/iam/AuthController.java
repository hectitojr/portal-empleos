package com.zoedatalab.empleos.api.web.controller.iam;

import com.zoedatalab.empleos.api.web.dto.iam.AuthResponse;
import com.zoedatalab.empleos.api.web.dto.iam.LoginRequest;
import com.zoedatalab.empleos.api.web.dto.iam.RefreshRequest;
import com.zoedatalab.empleos.api.web.dto.iam.RegisterRequest;
import com.zoedatalab.empleos.iam.application.dto.*;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService auth;

    @PostMapping(value = "/register", consumes = "application/json", produces = "application/json")
    public ResponseEntity<AuthResponse> register(@Valid @RequestBody RegisterRequest r) {
        var out = auth.register(RegisterCommand.builder()
                .email(r.email())
                .password(r.password())
                .role(r.role())
                .build());
        return ResponseEntity.status(HttpStatus.CREATED)
                .body(new AuthResponse(out.getTokenType(), out.getAccessToken(), out.getExpiresIn(), out.getRefreshToken()));
    }

    @PostMapping(value = "/login", consumes = "application/json", produces = "application/json")
    public ResponseEntity<AuthResponse> login(@Valid @RequestBody LoginRequest r) {
        var out = auth.login(LoginCommand.builder()
                .email(r.email())
                .password(r.password())
                .build());
        return ResponseEntity.ok(new AuthResponse(out.getTokenType(), out.getAccessToken(), out.getExpiresIn(), out.getRefreshToken()));
    }

    @PostMapping(value = "/refresh", consumes = "application/json", produces = "application/json")
    public ResponseEntity<AuthResponse> refresh(@Valid @RequestBody RefreshRequest r) {
        var out = auth.refresh(r.refreshToken());
        return ResponseEntity.ok(new AuthResponse(out.getTokenType(), out.getAccessToken(), out.getExpiresIn(), out.getRefreshToken()));
    }
}
