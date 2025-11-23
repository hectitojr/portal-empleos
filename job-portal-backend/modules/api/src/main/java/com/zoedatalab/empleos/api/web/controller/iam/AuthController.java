package com.zoedatalab.empleos.api.web.controller.iam;

import com.zoedatalab.empleos.api.security.CurrentUser;
import com.zoedatalab.empleos.api.web.dto.common.MessageResponse;
import com.zoedatalab.empleos.api.web.dto.iam.AuthMeResponse;
import com.zoedatalab.empleos.api.web.dto.iam.AuthResponse;
import com.zoedatalab.empleos.api.web.dto.iam.LoginRequest;
import com.zoedatalab.empleos.api.web.dto.iam.RefreshRequest;
import com.zoedatalab.empleos.api.web.dto.iam.RegisterRequest;
import com.zoedatalab.empleos.api.web.dto.iam.ForgotPasswordRequest;
import com.zoedatalab.empleos.api.web.dto.iam.ResetPasswordRequest;
import com.zoedatalab.empleos.iam.application.dto.*;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;
import org.springframework.context.MessageSource;
import org.springframework.context.i18n.LocaleContextHolder;
import org.springframework.http.CacheControl;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.context.request.WebRequest;

import java.time.OffsetDateTime;
import java.util.Optional;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/auth")
@RequiredArgsConstructor
public class AuthController {

    private final AuthService auth;
    private final MessageSource messages;

    @PostMapping(value = "/register", consumes = "application/json", produces = "application/json")
    public ResponseEntity<AuthResponse> register(@Valid @RequestBody RegisterRequest r) {
        var out = auth.register(RegisterCommand.builder()
                .email(r.email())
                .password(r.password())
                .role(r.role())
                .acceptTerms(r.acceptTerms())
                .acceptDataPolicy(r.acceptDataPolicy())
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

    // =========================================================
    // ME (usuario autenticado)
    // =========================================================
    @GetMapping(value = "/me", produces = "application/json")
    public ResponseEntity<AuthMeResponse> me() {
        UUID userId = CurrentUser.idOrThrow();
        var view = auth.me(userId);

        return ResponseEntity.ok(
                new AuthMeResponse(
                        view.id().toString(),
                        view.email(),
                        view.role().name()
                )
        );
    }

    @PostMapping(value = "/forgot-password", consumes = "application/json", produces = "application/json")
    public ResponseEntity<MessageResponse> forgotPassword(@Valid @RequestBody ForgotPasswordRequest r, WebRequest req) {
        auth.forgotPassword(ForgotPasswordCommand.builder().email(r.email()).build());

        var locale = LocaleContextHolder.getLocale();
        var body = new MessageResponse(
                "AUTH.FORGOT.ACCEPTED",
                messages.getMessage("auth.forgot.accepted", null, locale),
                extractTraceId(req),
                OffsetDateTime.now()
        );

        return ResponseEntity
                .status(HttpStatus.ACCEPTED) // 202
                .cacheControl(CacheControl.noStore())
                .body(body);
    }

    @PostMapping(value = "/reset-password", consumes = "application/json", produces = "application/json")
    public ResponseEntity<MessageResponse> resetPassword(@Valid @RequestBody ResetPasswordRequest r, WebRequest req) {
        auth.resetPassword(ResetPasswordCommand.builder()
                .selector(r.selector())
                .token(r.token())
                .newPassword(r.newPassword())
                .build());

        var locale = LocaleContextHolder.getLocale();
        var body = new MessageResponse(
                "AUTH.RESET.OK",
                messages.getMessage("auth.reset.ok", null, locale),
                extractTraceId(req),
                OffsetDateTime.now()
        );

        return ResponseEntity
                .ok()
                .cacheControl(CacheControl.noStore())
                .body(body);
    }

    private String extractTraceId(WebRequest req) {
        // Método ajustable a futuro para integrar trazabilidad profesional
        return Optional.ofNullable(req.getHeader("X-Trace-Id"))
                .orElse("n/a");
    }
}