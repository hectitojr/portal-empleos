package com.zoedatalab.empleos.persistence.jpa.jobs.adapter;

import com.zoedatalab.empleos.jobs.application.ports.out.JobApplicantStatePort;
import com.zoedatalab.empleos.persistence.jpa.applications.repository.JpaApplicationRepository;
import com.zoedatalab.empleos.persistence.jpa.jobs.entity.JobOfferViewEntity;
import com.zoedatalab.empleos.persistence.jpa.jobs.repository.JpaJobOfferViewRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Component;

import java.time.Instant;
import java.util.List;
import java.util.Set;
import java.util.UUID;
import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class JobApplicantStateAdapter implements JobApplicantStatePort {

    private final JpaApplicationRepository appRepo;
    private final JpaJobOfferViewRepository viewRepo;

    @Override
    public Set<UUID> findAppliedJobIds(UUID applicantId, List<UUID> jobIds) {
        if (jobIds == null || jobIds.isEmpty()) return Set.of();
        return appRepo.findAppliedJobIds(applicantId, jobIds);
    }

    @Override
    public Set<UUID> findViewedJobIds(UUID applicantId, List<UUID> jobIds) {
        if (jobIds == null || jobIds.isEmpty()) return Set.of();

        return viewRepo.findByApplicantIdAndJobIdIn(applicantId, jobIds)
                .stream()
                .map(JobOfferViewEntity::getJobId)
                .collect(Collectors.toSet());
    }

    @Override
    public void markViewed(UUID applicantId, UUID jobId, Instant viewedAt) {
        if (viewRepo.existsByApplicantIdAndJobId(applicantId, jobId)) return;

        try {
            viewRepo.save(
                    JobOfferViewEntity.builder()
                            .applicantId(applicantId)
                            .jobId(jobId)
                            .firstViewedAt(viewedAt != null ? viewedAt : Instant.now())
                            .build()
            );
        } catch (DataIntegrityViolationException ex) {
            log.warn("No se pudo registrar vista de oferta (posible duplicado): applicantId={} jobId={}", applicantId, jobId);
        }
    }

    @Override
    public boolean isApplied(UUID applicantId, UUID jobId) {
        return appRepo.existsByJobIdAndApplicantId(jobId, applicantId);
    }
}
