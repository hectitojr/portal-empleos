package com.zoedatalab.empleos.jobs.application.ports.in;

import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;
import java.time.Instant;
import java.util.List;
import java.util.UUID;

public interface JobQueryService {
    JobDetailView getById(UUID jobId);
    List<JobSummaryView> search(UUID areaId, UUID sectorId, UUID districtId,
                                Boolean disabilityFriendly, Instant fromDate,
                                int page, int size);
}
