-- File: V1_30__companies.sql
-- Title: Company profiles
-- Purpose: Perfiles de empresa asociados a user (1:1).
-- Author: ZOEDATA_LAB

SET search_path TO job_portal, public;

CREATE TABLE companies (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE RESTRICT,
  employer_type    TEXT NOT NULL DEFAULT 'COMPANY',
  legal_name       TEXT NULL,
  tax_id           TEXT NULL,
  contact_email    public.citext NULL,
  contact_phone    TEXT NULL,
  district_id      UUID NULL REFERENCES catalog_district(id) ON DELETE SET NULL,
  profile_complete BOOLEAN NOT NULL DEFAULT FALSE,
  active           BOOLEAN NOT NULL DEFAULT TRUE,
  suspended        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by       UUID NULL,
  updated_by       UUID NULL,

  CONSTRAINT chk_companies__employer_type
    CHECK (employer_type IN ('COMPANY','FREELANCE')),

  CONSTRAINT chk_companies__profile_complete_rules
    CHECK (
      profile_complete = FALSE
      OR (
        employer_type = 'COMPANY'
        AND tax_id IS NOT NULL AND btrim(tax_id) <> ''
        AND legal_name IS NOT NULL AND btrim(legal_name) <> ''
        AND contact_email IS NOT NULL AND btrim(contact_email) <> ''
        AND district_id IS NOT NULL
      )
      OR (
        employer_type = 'FREELANCE'
        AND (tax_id IS NULL OR btrim(tax_id) = '')
        AND legal_name IS NOT NULL AND btrim(legal_name) <> ''
        AND contact_email IS NOT NULL AND btrim(contact_email) <> ''
        AND district_id IS NOT NULL
      )
    )
);

CREATE INDEX ix_companies__active        ON companies(active);
CREATE INDEX ix_companies__suspended     ON companies(suspended);
CREATE INDEX ix_companies__employer_type ON companies(employer_type);

CREATE UNIQUE INDEX ux_companies__taxid_ci
  ON companies (lower(btrim(tax_id)))
  WHERE tax_id IS NOT NULL AND btrim(tax_id) <> '';

CREATE TRIGGER trg_companies__updated_at
  BEFORE UPDATE ON companies
  FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE companies IS 'Perfil de empresa (1:1 con users).';
COMMENT ON COLUMN companies.employer_type IS 'Tipo de empleador: COMPANY o FREELANCE.';
