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
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationCredentialsNotFoundException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Map;

@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(EmailAlreadyExistsException.class)
    public ResponseEntity<?> emailExists() {
        return error(HttpStatus.CONFLICT, "EMAIL_EXISTS");
    }

    @ExceptionHandler(AuthBadCredentialsException.class)
    public ResponseEntity<?> badCreds() {
        return error(HttpStatus.UNAUTHORIZED, "BAD_CREDENTIALS");
    }

    @ExceptionHandler(UserSuspendedException.class)
    public ResponseEntity<?> suspended() {
        return error(HttpStatus.UNAUTHORIZED, "USER_SUSPENDED");
    }

    @ExceptionHandler(TokenInvalidException.class)
    public ResponseEntity<?> invalidToken() {
        return error(HttpStatus.UNAUTHORIZED, "TOKEN_INVALID");
    }

    @ExceptionHandler(TokenExpiredException.class)
    public ResponseEntity<?> expiredToken() {
        return error(HttpStatus.UNAUTHORIZED, "TOKEN_EXPIRED");
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> validation(MethodArgumentNotValidException ex) {
        return ResponseEntity.badRequest().body(Map.of("error", "VALIDATION_ERROR"));
    }

    @ExceptionHandler(CompanyNotFoundException.class)
    public ResponseEntity<?> companyNotFound() {
        return error(HttpStatus.NOT_FOUND, "COMPANY_NOT_FOUND");
    }

    @ExceptionHandler(TaxIdAlreadyExistsException.class)
    public ResponseEntity<?> taxExists() {
        return error(HttpStatus.CONFLICT, "COMPANY_TAX_ID_ALREADY_EXISTS");
    }

    @ExceptionHandler(AuthenticationCredentialsNotFoundException.class)
    public ResponseEntity<?> unauthenticated() {
        return error(HttpStatus.UNAUTHORIZED, "UNAUTHENTICATED");
    }

    @ExceptionHandler(DistrictNotFoundException.class)
    public ResponseEntity<?> districtNotFound() {
        return error(HttpStatus.BAD_REQUEST, "DISTRICT_NOT_FOUND");
    }

    @ExceptionHandler(JobNotFoundException.class)
    public ResponseEntity<?> jobNotFound() {
        return error(HttpStatus.NOT_FOUND, "JOB_NOT_FOUND");
    }

    @ExceptionHandler(JobClosedException.class)
    public ResponseEntity<?> jobClosed() {
        return error(HttpStatus.CONFLICT, "JOB_CLOSED");
    }

    @ExceptionHandler(ForbiddenJobAccessException.class)
    public ResponseEntity<?> jobForbidden() {
        return error(HttpStatus.FORBIDDEN, "FORBIDDEN");
    }

    @ExceptionHandler(CompanyIncompleteException.class)
    public ResponseEntity<?> companyIncomplete() {
        return error(HttpStatus.BAD_REQUEST, "COMPANY_INCOMPLETE");
    }

    @ExceptionHandler(ApplicantNotFoundException.class)
    public ResponseEntity<?> applicantNotFound() {
        return error(HttpStatus.NOT_FOUND, "APPLICANT_NOT_FOUND");
    }

    private ResponseEntity<Map<String, String>> error(HttpStatus status, String code) {
        return ResponseEntity.status(status).body(Map.of("error", code));
    }
}
