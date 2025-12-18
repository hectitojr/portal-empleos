-- File: V1_55__job_offer_ui_fields_and_views.sql
-- Title: JobOffers UI fields + JobOfferViews (applicant -> job)
-- Purpose: Agregar campos necesarios para UI de ofertas
--          y persistir vistas cross-device por postulante.
-- Author: ZOEDATA_LAB | Date: 2025-11-24
-- Notes:
--   - Requiere que catalog_employment_type y catalog_work_mode existan antes.
--   - No incluye índices de búsqueda (ver V1_56__job_offers_indexes.sql).

-------------------------
-- 1) Campos UI en job_offers
-------------------------

ALTER TABLE job_offers
  ADD COLUMN employment_type_id UUID NULL
    REFERENCES catalog_employment_type(id) ON DELETE SET NULL,
  ADD COLUMN work_mode_id UUID NULL
    REFERENCES catalog_work_mode(id) ON DELETE SET NULL,
  ADD COLUMN salary_text TEXT NULL;

COMMENT ON COLUMN job_offers.employment_type_id
  IS 'Catálogo tipo de empleo (full-time, part-time, contrato, prácticas, etc.).';

COMMENT ON COLUMN job_offers.work_mode_id
  IS 'Catálogo modalidad de trabajo (presencial, remoto, híbrido, campo).';

COMMENT ON COLUMN job_offers.salary_text
  IS 'Texto libre para salario/beneficios mostrado en UI.';

-------------------------
-- 2) Vistas de ofertas por postulante (cross-device)
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
