package com.zoedatalab.empleos.api.web.exception;

import com.zoedatalab.empleos.applicants.domain.exception.ApplicantNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.CompanyNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.DistrictNotFoundException;
import com.zoedatalab.empleos.companies.domain.exception.TaxIdAlreadyExistsException;
import com.zoedatalab.empleos.iam.application.exception.*;
import com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException;
import com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import com.zoedatalab.empleos.applications.domain.exception.ApplicantProfileIncompleteException;
import com.zoedatalab.empleos.applications.domain.exception.DuplicateApplicationException;
import com.zoedatalab.empleos.applications.domain.exception.ApplicationNotFoundException;
import com.zoedatalab.empleos.iam.application.exception.ResetTokenInvalidException;
import com.zoedatalab.empleos.iam.application.exception.ResetTokenExpiredException;

import org.springframework.security.authorization.AuthorizationDeniedException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.ConstraintViolationException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.validation.BindException;
import org.springframework.web.HttpMediaTypeNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import java.util.List;
import java.util.Map;
import java.util.Optional;

@RestControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger log = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    private static final Map<Class<? extends Throwable>, ApiErrorCode> EX_MAP = Map.ofEntries(
            // IAM
            Map.entry(EmailAlreadyExistsException.class, ApiErrorCode.EMAIL_EXISTS),
            Map.entry(AuthBadCredentialsException.class, ApiErrorCode.BAD_CREDENTIALS),
            Map.entry(UserSuspendedException.class, ApiErrorCode.USER_SUSPENDED),
            Map.entry(TokenInvalidException.class, ApiErrorCode.TOKEN_INVALID),
            Map.entry(TokenExpiredException.class, ApiErrorCode.TOKEN_EXPIRED),
            Map.entry(ResetTokenInvalidException.class, ApiErrorCode.RESET_TOKEN_INVALID),
            Map.entry(ResetTokenExpiredException.class, ApiErrorCode.RESET_TOKEN_EXPIRED),
            Map.entry(AuthenticationCredentialsNotFoundException.class, ApiErrorCode.UNAUTHENTICATED),

            // Autorización
            Map.entry(AccessDeniedException.class, ApiErrorCode.FORBIDDEN),
            Map.entry(AuthorizationDeniedException.class, ApiErrorCode.FORBIDDEN),
            Map.entry(ForbiddenJobAccessException.class, ApiErrorCode.FORBIDDEN),

            // Companies
            Map.entry(CompanyNotFoundException.class, ApiErrorCode.COMPANY_NOT_FOUND),
            Map.entry(TaxIdAlreadyExistsException.class, ApiErrorCode.COMPANY_TAX_ID_ALREADY_EXISTS),
            Map.entry(DistrictNotFoundException.class, ApiErrorCode.DISTRICT_NOT_FOUND),
            Map.entry(CompanyIncompleteException.class, ApiErrorCode.COMPANY_INCOMPLETE),

            // Applicants
            Map.entry(ApplicantNotFoundException.class, ApiErrorCode.APPLICANT_NOT_FOUND),

            // Jobs
            Map.entry(JobNotFoundException.class, ApiErrorCode.JOB_NOT_FOUND),
            Map.entry(JobClosedException.class, ApiErrorCode.JOB_CLOSED),

            // Applications
            Map.entry(DuplicateApplicationException.class, ApiErrorCode.DUPLICATE_APPLICATION),
            Map.entry(ApplicantProfileIncompleteException.class, ApiErrorCode.APPLICANT_INCOMPLETE),
            Map.entry(ApplicationNotFoundException.class, ApiErrorCode.APPLICATION_NOT_FOUND)
    );

    // ===== Excepciones de dominio / seguridad mapeadas =====
    @ExceptionHandler({
            EmailAlreadyExistsException.class,
            AuthBadCredentialsException.class,
            UserSuspendedException.class,
            TokenInvalidException.class,
            TokenExpiredException.class,
            AuthenticationCredentialsNotFoundException.class,
            ResetTokenInvalidException.class,
            ResetTokenExpiredException.class,
            AccessDeniedException.class,
            AuthorizationDeniedException.class,
            ForbiddenJobAccessException.class,
            CompanyNotFoundException.class,
            TaxIdAlreadyExistsException.class,
            DistrictNotFoundException.class,
            CompanyIncompleteException.class,
            ApplicantNotFoundException.class,
            JobNotFoundException.class,
            JobClosedException.class,
            DuplicateApplicationException.class,
            ApplicantProfileIncompleteException.class,
            ApplicationNotFoundException.class
    })
    public ResponseEntity<ApiErrorResponse> mapped(HttpServletRequest req, Throwable ex) {
        ApiErrorCode code = EX_MAP.getOrDefault(ex.getClass(), ApiErrorCode.INTERNAL_ERROR);
        logByStatus(code, ex);
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, null));
    }

    // ===== Validación: @Valid (body) =====
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<ApiErrorResponse> validationBody(HttpServletRequest req, MethodArgumentNotValidException ex) {
        var fields = ex.getBindingResult().getFieldErrors().stream()
                .map(fe -> new FieldErrorItem(
                        fe.getField(),
                        fe.getCode(),
                        Optional.ofNullable(fe.getDefaultMessage()).orElse("Valor inválido")))
                .toList();
        var code = ApiErrorCode.VALIDATION_ERROR;
        log.warn("Validation body error: {} fields invalid", fields.size());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, fields, null));
    }

    // ===== Validación: @Validated (params) =====
    @ExceptionHandler(ConstraintViolationException.class)
    public ResponseEntity<ApiErrorResponse> constraintViolation(HttpServletRequest req, ConstraintViolationException ex) {
        var violations = ex.getConstraintViolations().stream()
                .map(this::toViolation)
                .toList();
        var code = ApiErrorCode.CONSTRAINT_VIOLATION;
        log.warn("Constraint violations: {}", violations.size());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, violations));
    }

    // ===== BindException (p.ej. @ModelAttribute) =====
    @ExceptionHandler(BindException.class)
    public ResponseEntity<ApiErrorResponse> bindException(HttpServletRequest req, BindException ex) {
        var fields = ex.getFieldErrors().stream()
                .map(fe -> new FieldErrorItem(
                        fe.getField(),
                        fe.getCode(),
                        Optional.ofNullable(fe.getDefaultMessage()).orElse("Valor inválido")))
                .toList();
        var code = ApiErrorCode.VALIDATION_ERROR;
        log.warn("BindException: {} fields invalid", fields.size());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, fields, null));
    }

    // ===== Errores de request/infra =====
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ApiErrorResponse> malformedJson(HttpServletRequest req, HttpMessageNotReadableException ex) {
        var code = ApiErrorCode.MALFORMED_JSON;
        log.warn("Malformed JSON: {}", ex.getMostSpecificCause().getMessage());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, null));
    }

    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ResponseEntity<ApiErrorResponse> missingParam(HttpServletRequest req, MissingServletRequestParameterException ex) {
        var code = ApiErrorCode.MISSING_PARAMETER;
        var v = List.of(new ViolationErrorItem(ex.getParameterName(), "MissingParameter", "El parámetro es obligatorio."));
        log.warn("Missing parameter: {}", ex.getParameterName());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, v));
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    public ResponseEntity<ApiErrorResponse> typeMismatch(HttpServletRequest req, MethodArgumentTypeMismatchException ex) {
        var code = ApiErrorCode.TYPE_MISMATCH;
        var v = List.of(new ViolationErrorItem(ex.getName(), "TypeMismatch", "Tipo de dato inválido."));
        log.warn("Type mismatch: {} -> {}", ex.getName(), ex.getValue());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, v));
    }

    @ExceptionHandler(HttpMediaTypeNotSupportedException.class)
    public ResponseEntity<ApiErrorResponse> unsupportedMedia(HttpServletRequest req, HttpMediaTypeNotSupportedException ex) {
        var code = ApiErrorCode.UNSUPPORTED_MEDIA_TYPE;
        log.warn("Unsupported media type: {}", ex.getContentType());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, null));
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    public ResponseEntity<ApiErrorResponse> dataIntegrity(HttpServletRequest req, DataIntegrityViolationException ex) {
        var code = ApiErrorCode.DATA_INTEGRITY_VIOLATION;
        log.warn("Data integrity violation: {}", ex.getMostSpecificCause().getMessage());
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, null));
    }

    // ===== Fallback =====
    @ExceptionHandler(Exception.class)
    public ResponseEntity<ApiErrorResponse> any(HttpServletRequest req, Exception ex) {
        var code = ApiErrorCode.INTERNAL_ERROR;
        log.error("Unhandled exception", ex);
        return ResponseEntity.status(code.status).body(ApiErrorFactory.build(req, code, null, null));
    }

    private ViolationErrorItem toViolation(ConstraintViolation<?> v) {
        String param = (v.getPropertyPath() != null) ? v.getPropertyPath().toString() : null;
        String code = (v.getConstraintDescriptor() != null && v.getConstraintDescriptor().getAnnotation() != null)
                ? v.getConstraintDescriptor().getAnnotation().annotationType().getSimpleName()
                : "ConstraintViolation";
        String message = Optional.ofNullable(v.getMessage()).orElse("Parámetro inválido");
        return new ViolationErrorItem(param, code, message);
    }

    private void logByStatus(ApiErrorCode code, Throwable ex) {
        if (code.status.is5xxServerError()) {
            log.error("{}", ex.getMessage(), ex);
        } else {
            log.warn("{}", ex.getMessage());
        }
    }
}
