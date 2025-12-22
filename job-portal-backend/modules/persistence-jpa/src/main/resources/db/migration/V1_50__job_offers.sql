-- File: V1_50__job_offers.sql
-- Title: Job offers
-- Purpose: Publicaciones de empleo asociadas a company.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

CREATE TABLE job_offers (
  id                  UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id          UUID NOT NULL REFERENCES companies(id) ON DELETE RESTRICT,
  title               TEXT NOT NULL,
  description         TEXT NOT NULL,
  area_id             UUID NULL REFERENCES catalog_area(id) ON DELETE SET NULL,
  sector_id           UUID NULL REFERENCES catalog_sector(id) ON DELETE SET NULL,
  district_id         UUID NOT NULL REFERENCES catalog_district(id) ON DELETE RESTRICT,
  disability_friendly BOOLEAN NOT NULL DEFAULT FALSE,
  employment_type_id  UUID NULL REFERENCES catalog_employment_type(id) ON DELETE SET NULL,
  work_mode_id        UUID NULL REFERENCES catalog_work_mode(id)       ON DELETE SET NULL,
  salary_text         TEXT NULL,
  status              TEXT NOT NULL CHECK (status IN ('OPEN','CLOSED')) DEFAULT 'OPEN',
  published_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  suspended           BOOLEAN NOT NULL DEFAULT FALSE,
  created_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at          TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by          UUID NULL,
  updated_by          UUID NULL,

  -- hardening title/description
  CONSTRAINT chk_job_offers_title_len CHECK (char_length(title) BETWEEN 1 AND 120),
  CONSTRAINT chk_job_offers_desc_len  CHECK (char_length(description) BETWEEN 1 AND 8000),
  CONSTRAINT chk_job_offers_title_not_blank CHECK (btrim(title) <> ''),
  CONSTRAINT chk_job_offers_desc_not_blank  CHECK (btrim(description) <> '')
);

-------------------------
-- Índices base
-------------------------

CREATE INDEX ix_job_offers__company_pub_id
  ON job_offers(company_id, published_at DESC, id DESC);

CREATE INDEX ix_job_offers__company_status_pub_id
  ON job_offers(company_id, status, published_at DESC, id DESC);

CREATE INDEX ix_job_offers__pub_suspended_pub_id
  ON job_offers(published_at DESC, id DESC)
  WHERE suspended = FALSE;

CREATE INDEX ix_job_offers__pub_district_pub_id
  ON job_offers(district_id, published_at DESC, id DESC)
  WHERE suspended = FALSE;

CREATE INDEX ix_job_offers__pub_sector_district_pub_id
  ON job_offers(sector_id, district_id, published_at DESC, id DESC)
  WHERE suspended = FALSE;

CREATE INDEX ix_job_offers__pub_area_pub_id
  ON job_offers(area_id, published_at DESC, id DESC)
  WHERE suspended = FALSE;

CREATE INDEX ix_job_offers__disability
  ON job_offers(disability_friendly);

CREATE INDEX ix_job_offers__employment_type
  ON job_offers(employment_type_id);

CREATE INDEX ix_job_offers__work_mode
  ON job_offers(work_mode_id);

CREATE INDEX ix_job_offers__title_lower_trgm
  ON job_offers USING gin ((lower(title)) public.gin_trgm_ops);

-------------------------
-- Trigger updated_at
-------------------------
CREATE TRIGGER trg_job_offers__updated_at
  BEFORE UPDATE ON job_offers FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE job_offers IS 'Oferta laboral publicada por una empresa.';
COMMENT ON COLUMN job_offers.employment_type_id IS 'Tipo de empleo (catálogo).';
COMMENT ON COLUMN job_offers.work_mode_id       IS 'Modalidad de trabajo (catálogo).';
COMMENT ON COLUMN job_offers.salary_text        IS 'Texto de salario/beneficios mostrado en UI (listado/detalle).';
