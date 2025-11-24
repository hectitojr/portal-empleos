package com.zoedatalab.empleos.api.web.controller.iam;

import com.zoedatalab.empleos.api.web.dto.common.MessageResponse;
import com.zoedatalab.empleos.api.web.dto.iam.ForgotPasswordRequest;
import com.zoedatalab.empleos.api.web.dto.iam.ResetPasswordRequest;
import com.zoedatalab.empleos.api.web.exception.GlobalExceptionHandler;
import com.zoedatalab.empleos.iam.application.dto.AuthMeView;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import com.zoedatalab.empleos.iam.domain.Role;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.Test;
import org.springframework.context.MessageSource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.request.WebRequest;

import java.util.List;
import java.util.Locale;
import java.util.UUID;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.any;
import static org.mockito.Mockito.eq;
import static org.mockito.Mockito.isNull;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.when;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

class AuthControllerTest {

    @AfterEach
    void tearDown() {
        SecurityContextHolder.clearContext();
    }

    @Test
    void me_returns_authenticated_user_view() throws Exception {
        AuthService auth = mock(AuthService.class);
        MessageSource messages = mock(MessageSource.class);

        AuthController controller = new AuthController(auth, messages);
        MockMvc mvc = MockMvcBuilders
                .standaloneSetup(controller)
                .setControllerAdvice(new GlobalExceptionHandler())
                .build();

        UUID userId = UUID.randomUUID();

        var authToken = new UsernamePasswordAuthenticationToken(
                userId.toString(),
                null,
                List.of()
        );
        SecurityContextHolder.getContext().setAuthentication(authToken);

        when(auth.me(userId))
                .thenReturn(new AuthMeView(userId, "a@a.com", Role.APPLICANT, true, false));

        mvc.perform(get("/api/v1/auth/me").accept(MediaType.APPLICATION_JSON))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.id").value(userId.toString()))
                .andExpect(jsonPath("$.email").value("a@a.com"))
                .andExpect(jsonPath("$.role").value("APPLICANT"));

        verify(auth).me(userId);
    }

    @Test
    void forgotPassword_returns202_and_localizedMessage() {
        AuthService auth = mock(AuthService.class);
        MessageSource ms = mock(MessageSource.class);
        WebRequest req = mock(WebRequest.class);

        when(ms.getMessage(eq("auth.forgot.accepted"), isNull(), any(Locale.class)))
                .thenReturn("OK-FORGOT");
        when(req.getHeader("X-Trace-Id")).thenReturn("trace-123");

        var controller = new AuthController(auth, ms);

        ResponseEntity<MessageResponse> resp = controller.forgotPassword(
                new ForgotPasswordRequest("user@job.com"), req);

        verify(auth).forgotPassword(any(ForgotPasswordCommand.class));
        assertThat(resp.getStatusCode().value()).isEqualTo(202);
        assertThat(resp.getBody()).isNotNull();
        assertThat(resp.getBody().message()).isEqualTo("OK-FORGOT");
        assertThat(resp.getBody().traceId()).isEqualTo("trace-123");
    }

    @Test
    void resetPassword_returns200_and_localizedMessage() {
        AuthService auth = mock(AuthService.class);
        MessageSource ms = mock(MessageSource.class);
        WebRequest req = mock(WebRequest.class);

        when(ms.getMessage(eq("auth.reset.ok"), isNull(), any(Locale.class)))
                .thenReturn("OK-RESET");
        when(req.getHeader("X-Trace-Id")).thenReturn("trace-456");

        var controller = new AuthController(auth, ms);

        ResponseEntity<MessageResponse> resp = controller.resetPassword(
                new ResetPasswordRequest("sel", "tok", "NewPass!123"), req);

        verify(auth).resetPassword(any(ResetPasswordCommand.class));
        assertThat(resp.getStatusCode().value()).isEqualTo(200);
        assertThat(resp.getBody()).isNotNull();
        assertThat(resp.getBody().message()).isEqualTo("OK-RESET");
        assertThat(resp.getBody().traceId()).isEqualTo("trace-456");
    }
}
