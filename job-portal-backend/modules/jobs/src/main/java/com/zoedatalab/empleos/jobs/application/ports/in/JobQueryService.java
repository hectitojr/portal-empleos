package com.zoedatalab.empleos.jobs.application.ports.in;

import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.ApplicantJobSummaryView;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public interface JobQueryService {

    JobDetailView getById(UUID jobId);

    List<JobSummaryView> search(
            UUID areaId,
            UUID sectorId,
            UUID departmentId,
            UUID provinceId,
            UUID districtId,
            Boolean disabilityFriendly,
            Instant fromDate,
            int page,
            int size
    );

    ApplicantJobDetailView getByIdForApplicant(UUID applicantUserId, UUID jobId);

    List<ApplicantJobSummaryView> searchForApplicant(
            UUID applicantUserId,
            UUID areaId,
            UUID sectorId,
            UUID departmentId,
            UUID provinceId,
            UUID districtId,
            Boolean disabilityFriendly,
            Instant fromDate,
            int page,
            int size
    );
}
