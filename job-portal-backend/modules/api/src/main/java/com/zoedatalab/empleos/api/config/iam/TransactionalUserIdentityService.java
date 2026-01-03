package com.zoedatalab.empleos.api.config.iam;

import com.zoedatalab.empleos.iam.application.dto.UpdateMyIdentityCommand;
import com.zoedatalab.empleos.iam.application.ports.in.UserIdentityService;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

public class TransactionalUserIdentityService implements UserIdentityService {

    private final UserIdentityService delegate;

    public TransactionalUserIdentityService(UserIdentityService delegate) {
        this.delegate = delegate;
    }

    @Override
    @Transactional
    public void updateMyIdentity(UUID userId, UpdateMyIdentityCommand cmd) {
        delegate.updateMyIdentity(userId, cmd);
    }
}
