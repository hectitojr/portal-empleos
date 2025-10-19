package com.zoedatalab.empleos.api.web.exception;

import com.zoedatalab.empleos.api.web.exception._support.SecurityTestConfig;
import com.zoedatalab.empleos.api.web.exception._support.TestErrorController;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Nested;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.context.annotation.Import;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@WebMvcTest(controllers = TestErrorController.class)
@Import({ GlobalExceptionHandler.class, ApiErrorHttpHandler.class, SecurityTestConfig.class })
class GlobalAndSecurityErrorHandlingTest {

    @Autowired
    MockMvc mvc;

    // ---------- Seguridad ----------
    @Nested
    class SecurityTests {
        @Test @DisplayName("401 UNAUTHENTICATED cuando no hay credenciales")
        void unauthenticated() throws Exception {
            mvc.perform(get("/test/protected"))
                    .andExpect(status().isUnauthorized())
                    .andExpect(jsonPath("$.error").value("UNAUTHENTICATED"))
                    .andExpect(jsonPath("$.status").value(401))
                    .andExpect(jsonPath("$.path").value("/test/protected"))
                    .andExpect(jsonPath("$.timestamp", notNullValue()));
        }

        @Test @DisplayName("401 TOKEN_EXPIRED cuando el filtro marca expirado")
        void tokenExpired() throws Exception {
            mvc.perform(get("/test/protected").header("X-Test-Auth", "expired"))
                    .andExpect(status().isUnauthorized())
                    .andExpect(jsonPath("$.error").value("TOKEN_EXPIRED"))
                    .andExpect(jsonPath("$.status").value(401));
        }

        @Test @DisplayName("401 TOKEN_INVALID cuando el filtro marca inválido")
        void tokenInvalid() throws Exception {
            mvc.perform(get("/test/protected").header("X-Test-Auth", "invalid"))
                    .andExpect(status().isUnauthorized())
                    .andExpect(jsonPath("$.error").value("TOKEN_INVALID"))
                    .andExpect(jsonPath("$.status").value(401));
        }

        @Test @DisplayName("403 FORBIDDEN cuando autenticado sin rol ADMIN")
        void forbidden() throws Exception {
            mvc.perform(get("/test/admin-only").header("X-Test-Auth", "ok"))
                    .andExpect(status().isForbidden())
                    .andExpect(jsonPath("$.error").value("FORBIDDEN"))
                    .andExpect(jsonPath("$.status").value(403));
        }
    }

    // ---------- Validaciones ----------
    @Nested
    class ValidationTests {
        @Test @DisplayName("400 VALIDATION_ERROR en @Valid body")
        void validationBody() throws Exception {
            String body = "{\"name\":\"\"}"; // NotBlank -> falla
            mvc.perform(post("/test/validation-body")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content(body))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.error").value("VALIDATION_ERROR"))
                    .andExpect(jsonPath("$.fieldErrors[0].field").value("name"))
                    .andExpect(jsonPath("$.status").value(400));
        }

        @Test @DisplayName("400 CONSTRAINT_VIOLATION en @Validated param")
        void constraintParam() throws Exception {
            mvc.perform(get("/test/constraint").param("id", "0")) // @Min(1)
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.error").value("CONSTRAINT_VIOLATION"))
                    .andExpect(jsonPath("$.violations", notNullValue()))
                    .andExpect(jsonPath("$.status").value(400));
        }
    }

    // ---------- Framework errors ----------
    @Nested
    class FrameworkTests {
        @Test @DisplayName("400 MALFORMED_JSON cuando JSON es inválido")
        void malformedJson() throws Exception {
            mvc.perform(post("/test/malformed")
                            .contentType(MediaType.APPLICATION_JSON)
                            .content("{invalid-json"))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.error").value("MALFORMED_JSON"));
        }

        @Test @DisplayName("400 MISSING_PARAMETER cuando falta param")
        void missingParam() throws Exception {
            mvc.perform(get("/test/missing"))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.error").value("MISSING_PARAMETER"));
        }

        @Test @DisplayName("400 TYPE_MISMATCH cuando tipo de param es inválido")
        void typeMismatch() throws Exception {
            mvc.perform(get("/test/type-mismatch").param("num", "abc"))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.error").value("TYPE_MISMATCH"));
        }

        @Test @DisplayName("415 UNSUPPORTED_MEDIA_TYPE cuando el Content-Type no coincide")
        void unsupportedMediaType() throws Exception {
            mvc.perform(post("/test/media")
                            .contentType(MediaType.TEXT_PLAIN)
                            .content("name=pepe"))
                    .andExpect(status().isUnsupportedMediaType())
                    .andExpect(jsonPath("$.error").value("UNSUPPORTED_MEDIA_TYPE"));
        }

        @Test @DisplayName("409 DATA_INTEGRITY_VIOLATION")
        void dataIntegrity() throws Exception {
            mvc.perform(get("/test/integrity"))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.error").value("DATA_INTEGRITY_VIOLATION"));
        }
    }

    // ---------- Dominio ----------
    @Nested
    class DomainTests {
        @Test @DisplayName("404 COMPANY_NOT_FOUND")
        void companyNotFound() throws Exception {
            mvc.perform(get("/test/domain/company-not-found"))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.error").value("COMPANY_NOT_FOUND"));
        }
        @Test @DisplayName("409 COMPANY_TAX_ID_ALREADY_EXISTS")
        void taxExists() throws Exception {
            mvc.perform(get("/test/domain/tax-exists"))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.error").value("COMPANY_TAX_ID_ALREADY_EXISTS"));
        }
        @Test @DisplayName("400 DISTRICT_NOT_FOUND")
        void districtNotFound() throws Exception {
            mvc.perform(get("/test/domain/district-not-found"))
                    .andExpect(status().isBadRequest())
                    .andExpect(jsonPath("$.error").value("DISTRICT_NOT_FOUND"));
        }
        @Test @DisplayName("404 APPLICANT_NOT_FOUND")
        void applicantNotFound() throws Exception {
            mvc.perform(get("/test/domain/applicant-not-found"))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.error").value("APPLICANT_NOT_FOUND"));
        }
        @Test @DisplayName("404 JOB_NOT_FOUND")
        void jobNotFound() throws Exception {
            mvc.perform(get("/test/domain/job-not-found"))
                    .andExpect(status().isNotFound())
                    .andExpect(jsonPath("$.error").value("JOB_NOT_FOUND"));
        }
        @Test @DisplayName("409 JOB_CLOSED")
        void jobClosed() throws Exception {
            mvc.perform(get("/test/domain/job-closed"))
                    .andExpect(status().isConflict())
                    .andExpect(jsonPath("$.error").value("JOB_CLOSED"));
        }
    }
}
