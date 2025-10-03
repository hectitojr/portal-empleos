package com.zoedatalab.empleos.api.adapters;

import com.zoedatalab.empleos.iam.application.ports.out.PasswordEncoderPort;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

@Component
@RequiredArgsConstructor
public class PasswordEncoderAdapter implements PasswordEncoderPort {
    private final PasswordEncoder delegate;

    @Override public String encode(String raw) { return delegate.encode(raw); }
    @Override public boolean matches(String raw, String encoded) { return delegate.matches(raw, encoded); }
}
