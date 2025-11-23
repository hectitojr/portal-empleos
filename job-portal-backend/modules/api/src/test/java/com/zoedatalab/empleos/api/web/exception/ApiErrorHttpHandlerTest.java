package com.zoedatalab.empleos.api.web.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import org.junit.jupiter.api.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import static org.junit.jupiter.api.Assertions.*;

class ApiErrorHttpHandlerTest {

    private final ObjectMapper mapper = new ObjectMapper()
            .registerModule(new JavaTimeModule());

    @Test
    void commence_writes_UNAUTHENTICATED_when_no_attr() throws Exception {
        ApiErrorHttpHandler sut = new ApiErrorHttpHandler(mapper);

        var req = new MockHttpServletRequest("GET", "/api/v1/auth/me");
        var res = new MockHttpServletResponse();

        sut.commence(req, res, null);

        assertEquals(401, res.getStatus());
        String body = res.getContentAsString();
        assertTrue(body.contains("\"error\":\"UNAUTHENTICATED\""));
    }

    @Test
    void commence_writes_attr_error_code() throws Exception {
        ApiErrorHttpHandler sut = new ApiErrorHttpHandler(mapper);

        var req = new MockHttpServletRequest("GET", "/api/v1/auth/me");
        req.setAttribute(ApiErrorHttpHandler.AUTH_ERROR_CODE_ATTR, ApiErrorCode.TOKEN_INVALID);
        var res = new MockHttpServletResponse();

        sut.commence(req, res, null);

        assertEquals(401, res.getStatus());
        String body = res.getContentAsString();
        assertTrue(body.contains("\"error\":\"TOKEN_INVALID\""));
    }

    @Test
    void handle_writes_FORBIDDEN_when_no_attr() throws Exception {
        ApiErrorHttpHandler sut = new ApiErrorHttpHandler(mapper);

        var req = new MockHttpServletRequest("GET", "/api/v1/secure");
        var res = new MockHttpServletResponse();

        sut.handle(req, res, null);

        assertEquals(403, res.getStatus());
        String body = res.getContentAsString();
        assertTrue(body.contains("\"error\":\"FORBIDDEN\""));
    }
}
