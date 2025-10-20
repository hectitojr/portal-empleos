-- File: V1_50__job_offers.sql
-- Title: Job offers
-- Purpose: Publicaciones de empleo asociadas a company.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

CREATE TABLE job_offers (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  company_id         UUID NOT NULL REFERENCES companies(id) ON DELETE RESTRICT,
  title              TEXT NOT NULL,
  description        TEXT NOT NULL,
  area_id            UUID NULL REFERENCES catalog_area(id) ON DELETE SET NULL,
  sector_id          UUID NULL REFERENCES catalog_sector(id) ON DELETE SET NULL,
  district_id        UUID NULL REFERENCES catalog_district(id) ON DELETE SET NULL,
  disability_friendly BOOLEAN NOT NULL DEFAULT FALSE,
  status             TEXT NOT NULL CHECK (status IN ('OPEN','CLOSED')) DEFAULT 'OPEN',
  published_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  suspended          BOOLEAN NOT NULL DEFAULT FALSE,
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by         UUID NULL,
  updated_by         UUID NULL
);

CREATE INDEX ix_job_offers__status     ON job_offers(status);
CREATE INDEX ix_job_offers__sector     ON job_offers(sector_id);
CREATE INDEX ix_job_offers__district   ON job_offers(district_id);
CREATE INDEX ix_job_offers__published  ON job_offers(published_at DESC);
CREATE INDEX ixp_job_offers__open      ON job_offers(id) WHERE status = 'OPEN';
CREATE INDEX ixp_job_offers__visible   ON job_offers(id) WHERE suspended = FALSE;

CREATE TRIGGER trg_job_offers__updated_at
  BEFORE UPDATE ON job_offers FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE job_offers IS 'Oferta laboral publicada por una empresa.';
