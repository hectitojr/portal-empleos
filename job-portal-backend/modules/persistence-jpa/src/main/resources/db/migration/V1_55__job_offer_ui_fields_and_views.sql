-- File: V1_55__job_offer_ui_fields_and_views.sql
-- Title: JobOfferViews (applicant -> job)
-- Purpose:
--   - Persistir vistas cross-device por postulante (job_offer_views)
-- Author: ZOEDATA_LAB | Date: 2025-11-24
-- Notes:
--   - Requiere applicants (V1_40) y job_offers (V1_50).

-------------------------
-- 1) Vistas de ofertas por postulante (cross-device)
-------------------------

CREATE TABLE job_offer_views (
  applicant_id     UUID NOT NULL
    REFERENCES applicants(id) ON DELETE CASCADE,
  job_id           UUID NOT NULL
    REFERENCES job_offers(id) ON DELETE CASCADE,
  first_viewed_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  PRIMARY KEY (applicant_id, job_id)
);

CREATE INDEX ix_job_offer_views__applicant
  ON job_offer_views(applicant_id, first_viewed_at DESC);

CREATE INDEX ix_job_offer_views__job
  ON job_offer_views(job_id);

COMMENT ON TABLE job_offer_views
  IS 'Vistas persistidas de ofertas por postulante (flag visto cross-device).';
