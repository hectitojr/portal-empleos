package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.api.config.iam.TransactionalAuthService;
import com.zoedatalab.empleos.iam.application.dto.AuthTokens;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.LoginCommand;
import com.zoedatalab.empleos.iam.application.dto.RegisterCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertSame;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;
import static org.mockito.Mockito.when;

class TransactionalAuthServiceTest {

    private AuthService delegate;
    private TransactionalAuthService sut;

    @BeforeEach
    void setUp() {
        delegate = mock(AuthService.class);
        sut = new TransactionalAuthService(delegate);
    }

    @Test
    void register_delegates_and_returns_value() {
        RegisterCommand cmd = mock(RegisterCommand.class);

        AuthTokens tokens = AuthTokens.builder()
                .tokenType("Bearer")
                .accessToken("acc")
                .expiresIn(900)
                .refreshToken("ref")
                .build();

        when(delegate.register(cmd)).thenReturn(tokens);

        AuthTokens out = sut.register(cmd);

        assertSame(tokens, out);
        verify(delegate).register(cmd);
        verifyNoMoreInteractions(delegate);
    }

    @Test
    void login_delegates_and_returns_value() {
        LoginCommand cmd = mock(LoginCommand.class);

        AuthTokens tokens = AuthTokens.builder()
                .tokenType("Bearer")
                .accessToken("acc")
                .expiresIn(900)
                .refreshToken("ref")
                .build();

        when(delegate.login(cmd)).thenReturn(tokens);

        AuthTokens out = sut.login(cmd);

        assertSame(tokens, out);
        verify(delegate).login(cmd);
        verifyNoMoreInteractions(delegate);
    }

    @Test
    void refresh_delegates_and_returns_value() {
        String refreshToken = "rt";

        AuthTokens tokens = AuthTokens.builder()
                .tokenType("Bearer")
                .accessToken("acc2")
                .expiresIn(900)
                .refreshToken("ref2")
                .build();

        when(delegate.refresh(refreshToken)).thenReturn(tokens);

        AuthTokens out = sut.refresh(refreshToken);

        assertSame(tokens, out);
        verify(delegate).refresh(refreshToken);
        verifyNoMoreInteractions(delegate);
    }

    @Test
    void forgotPassword_delegates() {
        ForgotPasswordCommand cmd = mock(ForgotPasswordCommand.class);

        sut.forgotPassword(cmd);

        verify(delegate).forgotPassword(cmd);
        verifyNoMoreInteractions(delegate);
    }

    @Test
    void resetPassword_delegates() {
        ResetPasswordCommand cmd = mock(ResetPasswordCommand.class);

        sut.resetPassword(cmd);

        verify(delegate).resetPassword(cmd);
        verifyNoMoreInteractions(delegate);
    }

}
