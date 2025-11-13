package com.zoedatalab.empleos.api.web.controller.iam;

import com.zoedatalab.empleos.api.web.dto.common.MessageResponse;
import com.zoedatalab.empleos.api.web.dto.iam.ForgotPasswordRequest;
import com.zoedatalab.empleos.api.web.dto.iam.ResetPasswordRequest;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import org.junit.jupiter.api.Test;
import org.springframework.context.MessageSource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.context.request.WebRequest;

import java.util.Locale;

import static org.assertj.core.api.Assertions.assertThat;
import static org.mockito.Mockito.*;

class AuthControllerTest {

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