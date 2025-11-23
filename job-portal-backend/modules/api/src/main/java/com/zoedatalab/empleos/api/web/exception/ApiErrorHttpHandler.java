package com.zoedatalab.empleos.api.web.exception;

import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
@RequiredArgsConstructor
public class ApiErrorHttpHandler implements AuthenticationEntryPoint, AccessDeniedHandler {

    public static final String AUTH_ERROR_CODE_ATTR = "AUTH_ERROR_CODE";

    private static final Logger log = LoggerFactory.getLogger(ApiErrorHttpHandler.class);

    private final ObjectMapper mapper;

    @Override
    public void commence(HttpServletRequest request,
                         HttpServletResponse response,
                         org.springframework.security.core.AuthenticationException authException) throws IOException {

        Object attr = request.getAttribute(AUTH_ERROR_CODE_ATTR);

        ApiErrorCode code = (attr instanceof ApiErrorCode c)
                ? c
                : ApiErrorCode.UNAUTHENTICATED;

        write(response, request, code);
    }

    @Override
    public void handle(HttpServletRequest request,
                       HttpServletResponse response,
                       AccessDeniedException accessDeniedException) throws IOException {

        Object attr = request.getAttribute(AUTH_ERROR_CODE_ATTR);
        ApiErrorCode code = (attr instanceof ApiErrorCode c) ? c : ApiErrorCode.FORBIDDEN;

        write(response, request, code);
    }

    private void write(HttpServletResponse res, HttpServletRequest req, ApiErrorCode code) throws IOException {
        if (res.isCommitted()) {
            log.warn("Response already committed. Skipping error write: {}", code.name());
            return;
        }

        var body = ApiErrorFactory.build(req, code, null, null);

        if (code.status.is5xxServerError()) {
            log.error("Security error {} -> {}", code.name(), code.status.value());
        } else {
            log.warn("Security error {} -> {}", code.name(), code.status.value());
        }

        res.setStatus(code.status.value());
        res.setContentType(MediaType.APPLICATION_JSON_VALUE);
        res.setCharacterEncoding("UTF-8");
        mapper.writeValue(res.getWriter(), body);
        res.getWriter().flush();
    }
}
