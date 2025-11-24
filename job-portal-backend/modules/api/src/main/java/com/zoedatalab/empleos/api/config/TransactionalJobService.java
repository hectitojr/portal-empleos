package com.zoedatalab.empleos.api.config;

import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;
import com.zoedatalab.empleos.jobs.application.ports.in.JobCommandService;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import org.springframework.transaction.annotation.Transactional;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

public class TransactionalJobService implements JobCommandService, JobQueryService {

    private final JobCommandService cmd;
    private final JobQueryService qry;

    public TransactionalJobService(JobCommandService cmd, JobQueryService qry) {
        this.cmd = cmd;
        this.qry = qry;
    }

    @Override
    @Transactional
    public JobDetailView create(UUID companyUserId, CreateJobCommand c) {
        return cmd.create(companyUserId, c);
    }

    @Override
    @Transactional
    public JobDetailView update(UUID companyUserId, UUID jobId, UpdateJobCommand c) {
        return cmd.update(companyUserId, jobId, c);
    }

    @Override
    @Transactional
    public JobDetailView close(UUID companyUserId, UUID jobId) {
        return cmd.close(companyUserId, jobId);
    }

    @Override
    @Transactional(readOnly = true)
    public JobDetailView getById(UUID jobId) {
        return qry.getById(jobId);
    }

    @Override
    @Transactional(readOnly = true)
    public List<JobSummaryView> search(UUID areaId, UUID sectorId, UUID districtId,
                                       Boolean disabilityFriendly, Instant fromDate,
                                       int page, int size) {
        return qry.search(areaId, sectorId, districtId, disabilityFriendly, fromDate, page, size);
    }
}
