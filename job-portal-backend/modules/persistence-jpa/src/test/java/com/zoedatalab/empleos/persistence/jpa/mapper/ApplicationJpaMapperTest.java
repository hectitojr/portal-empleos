package com.zoedatalab.empleos.persistence.jpa.mapper;

import com.zoedatalab.empleos.applications.domain.Application;
import com.zoedatalab.empleos.persistence.jpa.entity.ApplicationEntity;
import org.junit.jupiter.api.Test;

import java.time.Instant;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.assertEquals;

class ApplicationJpaMapperTest {

    private final ApplicationJpaMapper mapper = new ApplicationJpaMapper();

    @Test
    void roundtrip_ok() {
        var now = Instant.now();
        var id = UUID.randomUUID();
        var jobId = UUID.randomUUID();
        var applicantId = UUID.randomUUID();

        var domain = Application.builder()
                .id(id)
                .jobId(jobId)
                .applicantId(applicantId)
                .status(Application.Status.APPLIED)
                .notes("n")
                .appliedAt(now)
                .updatedAt(now)
                .createdBy(UUID.randomUUID())
                .updatedBy(UUID.randomUUID())
                .build();

        ApplicationEntity entity = mapper.toEntity(domain);
        assertEquals(ApplicationEntity.Status.APPLIED, entity.getStatus());

        Application back = mapper.toDomain(entity);
        assertEquals(domain.getId(), back.getId());
        assertEquals(domain.getStatus(), back.getStatus());
        assertEquals("n", back.getNotes());
    }
}