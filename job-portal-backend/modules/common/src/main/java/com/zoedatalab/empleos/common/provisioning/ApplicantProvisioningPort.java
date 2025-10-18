package com.zoedatalab.empleos.common.provisioning;

import java.util.UUID;

@FunctionalInterface
public interface ApplicantProvisioningPort {
    void provision(UUID userId);
}
