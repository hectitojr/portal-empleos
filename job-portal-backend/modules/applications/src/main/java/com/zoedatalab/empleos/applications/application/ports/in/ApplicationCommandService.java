package com.zoedatalab.empleos.applications.application.ports.in;

import com.zoedatalab.empleos.applications.application.dto.ApplicationView;
import com.zoedatalab.empleos.applications.application.dto.ApplyToJobCommand;
import com.zoedatalab.empleos.applications.application.dto.UpdateApplicationStatusCommand;

import java.util.UUID;

public interface ApplicationCommandService {
    ApplicationView apply(UUID applicantUserId, UUID jobId, ApplyToJobCommand cmd);
    ApplicationView updateStatus(UUID companyUserId, UUID applicationId, UpdateApplicationStatusCommand cmd);
}
