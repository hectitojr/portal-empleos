package com.zoedatalab.empleos.api.web.exception;

import com.zoedatalab.empleos.iam.application.exception.*;
import org.springframework.http.*;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    // 409 – conflicto funcional (email ya usado)
    @ExceptionHandler(EmailAlreadyExistsException.class)
    public ResponseEntity<?> emailExists() {
        return error(HttpStatus.CONFLICT, "EMAIL_EXISTS");
    }

    // 401 – credenciales inválidas
    @ExceptionHandler(AuthBadCredentialsException.class)
    public ResponseEntity<?> badCreds() {
        return error(HttpStatus.UNAUTHORIZED, "BAD_CREDENTIALS");
    }

    // 401 – usuario suspendido/inactivo (alineado con respuestas de auth)
    @ExceptionHandler(UserSuspendedException.class)
    public ResponseEntity<?> suspended() {
        return error(HttpStatus.UNAUTHORIZED, "USER_SUSPENDED");
    }

    // 401 – refresh/access token inválido
    @ExceptionHandler(TokenInvalidException.class)
    public ResponseEntity<?> invalidToken() {
        return error(HttpStatus.UNAUTHORIZED, "TOKEN_INVALID");
    }

    // 401 – refresh/access token expirado
    @ExceptionHandler(TokenExpiredException.class)
    public ResponseEntity<?> expiredToken() {
        return error(HttpStatus.UNAUTHORIZED, "TOKEN_EXPIRED");
    }

    // 400 – validación de payloads (@Valid)
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> validation(MethodArgumentNotValidException ex) {
        return ResponseEntity.badRequest().body(Map.of("error", "VALIDATION_ERROR"));
    }

    private ResponseEntity<Map<String, String>> error(HttpStatus status, String code) {
        return ResponseEntity.status(status).body(Map.of("error", code));
    }
}
