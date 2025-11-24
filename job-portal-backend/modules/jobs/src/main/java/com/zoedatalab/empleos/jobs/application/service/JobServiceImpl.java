package com.zoedatalab.empleos.jobs.application.service;

import com.zoedatalab.empleos.jobs.application.dto.CreateJobCommand;
import com.zoedatalab.empleos.jobs.application.dto.JobDetailView;
import com.zoedatalab.empleos.jobs.application.dto.JobSummaryView;
import com.zoedatalab.empleos.jobs.application.dto.UpdateJobCommand;
import com.zoedatalab.empleos.jobs.application.ports.in.JobCommandService;
import com.zoedatalab.empleos.jobs.application.ports.in.JobQueryService;
import com.zoedatalab.empleos.jobs.application.ports.out.CompanyOwnershipPort;
import com.zoedatalab.empleos.jobs.application.ports.out.JobRepositoryPort;
import com.zoedatalab.empleos.jobs.domain.JobOffer;
import com.zoedatalab.empleos.jobs.domain.JobOffer.Status;
import com.zoedatalab.empleos.jobs.domain.exception.CompanyIncompleteException;
import com.zoedatalab.empleos.jobs.domain.exception.ForbiddenJobAccessException;
import com.zoedatalab.empleos.jobs.domain.exception.JobClosedException;
import com.zoedatalab.empleos.jobs.domain.exception.JobNotFoundException;
import lombok.RequiredArgsConstructor;

import java.time.Instant;
import java.util.List;
import java.util.UUID;

@RequiredArgsConstructor
public class JobServiceImpl implements JobCommandService, JobQueryService {

    private final JobRepositoryPort repo;
    private final CompanyOwnershipPort ownership;

    @Override
    public JobDetailView create(UUID companyUserId, CreateJobCommand cmd) {
        var own = ownership.getForUser(companyUserId);
        if (own.companyId() == null || !own.active() || !own.profileComplete())
            throw new CompanyIncompleteException();

        var now = Instant.now();
        var job = JobOffer.builder()
                .id(UUID.randomUUID())
                .companyId(own.companyId())
                .title(cmd.title())
                .description(cmd.description())
                .areaId(cmd.areaId())
                .sectorId(cmd.sectorId())
                .districtId(cmd.districtId())
                .disabilityFriendly(cmd.disabilityFriendly())
                .status(Status.OPEN)
                .publishedAt(now)
                .suspended(false)
                .build();

        job = repo.save(job);
        return detail(job);
    }

    @Override
    public JobDetailView update(UUID companyUserId, UUID jobId, UpdateJobCommand cmd) {
        var own = ownership.getForUser(companyUserId);
        var job = repo.findById(jobId).orElseThrow(JobNotFoundException::new);

        if (!repo.isOwner(jobId, own.companyId()))
            throw new ForbiddenJobAccessException();
        if (job.getStatus() == Status.CLOSED) throw new JobClosedException();

        job.edit(cmd.title(), cmd.description(), cmd.areaId(), cmd.sectorId(), cmd.districtId(), cmd.disabilityFriendly());
        job = repo.save(job);
        return detail(job);
    }

    @Override
    public JobDetailView close(UUID companyUserId, UUID jobId) {
        var own = ownership.getForUser(companyUserId);
        var job = repo.findById(jobId).orElseThrow(JobNotFoundException::new);
        if (!repo.isOwner(jobId, own.companyId()))
            throw new ForbiddenJobAccessException();

        job.close();
        job = repo.save(job);
        return detail(job);
    }

    @Override
    public JobDetailView getById(UUID jobId) {
        return repo.findById(jobId).map(this::detail).orElseThrow(JobNotFoundException::new);
    }

    @Override
    public List<JobSummaryView> search(UUID areaId, UUID sectorId, UUID districtId,
                                       Boolean disabilityFriendly, Instant fromDate,
                                       int page, int size) {
        return repo.search(areaId, sectorId, districtId, disabilityFriendly, fromDate, page, size).stream()
                .map(j -> new JobSummaryView(
                        j.getId(), j.getTitle(), j.getCompanyId(),
                        ownership.publicName(j.getCompanyId()),
                        j.getSectorId(), j.getDistrictId(),
                        j.isDisabilityFriendly(),
                        j.getStatus().name(), j.getPublishedAt()
                )).toList();
    }

    private JobDetailView detail(JobOffer j) {
        return new JobDetailView(
                j.getId(), j.getCompanyId(), j.getTitle(), j.getDescription(),
                j.getAreaId(), j.getSectorId(), j.getDistrictId(),
                j.isDisabilityFriendly(), j.getStatus().name(), j.getPublishedAt(), j.isSuspended()
        );
    }
}
