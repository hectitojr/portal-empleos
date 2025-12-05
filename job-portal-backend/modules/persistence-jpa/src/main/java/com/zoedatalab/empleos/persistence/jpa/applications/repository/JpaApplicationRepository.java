package com.zoedatalab.empleos.persistence.jpa.applications.repository;

import com.zoedatalab.empleos.persistence.jpa.applications.entity.ApplicationEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Set;
import java.util.UUID;

public interface JpaApplicationRepository extends JpaRepository<ApplicationEntity, UUID> {

    boolean existsByJobIdAndApplicantId(UUID jobId, UUID applicantId);

    Page<ApplicationEntity> findByApplicantId(UUID applicantId, Pageable pageable);

    Page<ApplicationEntity> findByJobId(UUID jobId, Pageable pageable);

    @Query("""
            select a.jobId
            from ApplicationEntity a
            where a.applicantId = :applicantId
              and a.jobId in :jobIds
            """)
    Set<UUID> findAppliedJobIds(@Param("applicantId") UUID applicantId,
                                @Param("jobIds") List<UUID> jobIds);
}
