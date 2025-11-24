package com.zoedatalab.empleos.iam.application.ports.in;

import com.zoedatalab.empleos.iam.application.dto.AuthMeView;
import com.zoedatalab.empleos.iam.application.dto.AuthTokens;
import com.zoedatalab.empleos.iam.application.dto.ForgotPasswordCommand;
import com.zoedatalab.empleos.iam.application.dto.LoginCommand;
import com.zoedatalab.empleos.iam.application.dto.RegisterCommand;
import com.zoedatalab.empleos.iam.application.dto.ResetPasswordCommand;

import java.util.UUID;

public interface AuthService {
    AuthTokens register(RegisterCommand cmd);
    AuthTokens login(LoginCommand cmd);
    AuthTokens refresh(String refreshToken);
    void forgotPassword(ForgotPasswordCommand cmd);
    void resetPassword(ResetPasswordCommand cmd);
    AuthMeView me(UUID userId);
}
