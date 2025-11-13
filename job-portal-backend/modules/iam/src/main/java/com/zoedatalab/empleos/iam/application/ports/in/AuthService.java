package com.zoedatalab.empleos.iam.application.ports.in;

import com.zoedatalab.empleos.iam.application.dto.*;

public interface AuthService {
    AuthTokens register(RegisterCommand cmd);
    AuthTokens login(LoginCommand cmd);
    AuthTokens refresh(String refreshToken);
    void forgotPassword(ForgotPasswordCommand cmd);
    void resetPassword(ResetPasswordCommand cmd);
}
