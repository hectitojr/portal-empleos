package com.zoedatalab.empleos.iam.application.ports.in;

import com.zoedatalab.empleos.iam.application.dto.UpdateMyIdentityCommand;

import java.util.UUID;

public interface UserIdentityService {
    void updateMyIdentity(UUID userId, UpdateMyIdentityCommand cmd);
}
