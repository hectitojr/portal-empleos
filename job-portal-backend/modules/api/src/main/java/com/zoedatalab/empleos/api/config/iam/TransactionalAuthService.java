package com.zoedatalab.empleos.api.config.iam;

import com.zoedatalab.empleos.iam.application.dto.AuthMeView;
import com.zoedatalab.empleos.iam.application.dto.AuthTokens;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.LoginCommand;
import com.zoedatalab.empleos.iam.application.dto.RegisterCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;
import com.zoedatalab.empleos.iam.application.ports.in.AuthService;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

public class TransactionalAuthService implements AuthService {

    private final AuthService delegate;

    public TransactionalAuthService(AuthService delegate) {
        this.delegate = delegate;
    }

    @Override
    @Transactional
    public AuthTokens register(RegisterCommand cmd) {
        return delegate.register(cmd);
    }

    @Override
    @Transactional
    public AuthTokens login(LoginCommand cmd) {
        return delegate.login(cmd);
    }

    @Override
    @Transactional
    public AuthTokens refresh(String refreshToken) {
        return delegate.refresh(refreshToken);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional
    public void forgotPassword(ForgotPasswordCommand cmd) {
        delegate.forgotPassword(cmd);
    }

    @Override
    @org.springframework.transaction.annotation.Transactional
    public void resetPassword(ResetPasswordCommand cmd) {
        delegate.resetPassword(cmd);
    }

    @Override
    @Transactional(readOnly = true)
    public AuthMeView me(UUID userId) {
        return delegate.me(userId);
    }
}
