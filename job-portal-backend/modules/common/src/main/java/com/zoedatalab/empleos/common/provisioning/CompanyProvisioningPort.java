package com.zoedatalab.empleos.common.provisioning;

import java.util.UUID;

public interface CompanyProvisioningPort {
    void provision(UUID userId);
}
