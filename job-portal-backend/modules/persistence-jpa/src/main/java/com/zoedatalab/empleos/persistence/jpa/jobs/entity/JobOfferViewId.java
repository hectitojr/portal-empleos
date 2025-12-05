package com.zoedatalab.empleos.persistence.jpa.jobs.entity;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.io.Serializable;
import java.util.UUID;

/**
 * PK compuesta para job_offer_views.
 */
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class JobOfferViewId implements Serializable {
    private UUID applicantId;
    private UUID jobId;
}
