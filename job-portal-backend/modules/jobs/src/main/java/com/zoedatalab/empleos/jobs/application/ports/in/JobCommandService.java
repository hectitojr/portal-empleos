package com.zoedatalab.empleos.jobs.application.ports.in;

import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;

import java.util.UUID;

public interface JobCommandService {
    JobDetailView create(UUID companyUserId, CreateJobCommand cmd);
    JobDetailView update(UUID companyUserId, UUID jobId, UpdateJobCommand cmd);
    JobDetailView close(UUID companyUserId, UUID jobId);
}
