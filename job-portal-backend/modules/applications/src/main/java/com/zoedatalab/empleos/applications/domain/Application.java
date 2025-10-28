package com.zoedatalab.empleos.applications.domain;

import lombok.*;
import java.time.Instant;
import java.util.UUID;

@Getter @Setter @Builder
@AllArgsConstructor @NoArgsConstructor
public class Application {
    private UUID id;
    private UUID jobId;
    private UUID applicantId;
    private Status status;
    private String notes;
    private Instant appliedAt;
    private Instant updatedAt;
    private UUID createdBy;
    private UUID updatedBy;

    public enum Status { APPLIED, IN_REVIEW, SHORTLISTED, HIRED, REJECTED }

    public void moveTo(Status next) {
        if (this.status == Status.HIRED || this.status == Status.REJECTED) {
            throw new IllegalStateException("APPLICATION_FINALIZED");
        }
        this.status = next;
    }
}
