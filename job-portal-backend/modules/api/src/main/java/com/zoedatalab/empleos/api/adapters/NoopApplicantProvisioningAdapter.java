package com.zoedatalab.empleos.api.adapters;

import com.zoedatalab.empleos.iam.application.ports.out.ApplicantProvisioningPort;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Profile;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Profile({"dev","local"}) // opcional: solo en perfiles no productivos
@Component
public class NoopApplicantProvisioningAdapter implements ApplicantProvisioningPort {
    private static final Logger log = LoggerFactory.getLogger(NoopApplicantProvisioningAdapter.class);

    @Override
    public void provision(UUID userId) {
        log.info("Applicant provision noop for {}", userId);
    }
}
