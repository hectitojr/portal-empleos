package com.zoedatalab.empleos.applications.application.ports.in;

import com.zoedatalab.empleos.applications.application.dto.*;
import java.util.UUID;

public interface ApplicationCommandService {
    ApplicationView apply(UUID applicantUserId, UUID jobId, ApplyToJobCommand cmd);
    ApplicationView updateStatus(UUID companyUserId, UUID applicationId, UpdateApplicationStatusCommand cmd);
}
