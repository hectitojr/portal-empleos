package com.zoedatalab.empleos.api.web.exception;

import com.zoedatalab.empleos.iam.application.exception.EmailAlreadyExistsException;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.security.core.AuthenticationException;

import static org.junit.jupiter.api.Assertions.*;

class GlobalExceptionHandlerTest {

    private final GlobalExceptionHandler sut = new GlobalExceptionHandler();

    @Test
    void mapped_resolves_exact_exception() {
        var req = new MockHttpServletRequest("POST", "/api/v1/auth/register");

        var resp = sut.mapped(req, new EmailAlreadyExistsException());

        assertEquals(409, resp.getStatusCode().value());
        assertNotNull(resp.getBody());
        assertEquals("EMAIL_EXISTS", resp.getBody().error());
    }

    @Test
    void mapped_resolves_base_auth_exception_for_subclass() {
        class CustomAuthEx extends AuthenticationException {
            CustomAuthEx() { super("x"); }
        }

        var req = new MockHttpServletRequest("GET", "/api/v1/auth/me");
        var resp = sut.mapped(req, new CustomAuthEx());

        assertEquals(401, resp.getStatusCode().value());
        assertNotNull(resp.getBody());
        assertEquals("UNAUTHENTICATED", resp.getBody().error());
    }
}
