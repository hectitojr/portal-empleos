-- File: V1_30__companies.sql
-- Title: Company profiles
-- Purpose: Perfiles de empresa asociados a user (1:1).
-- Author: ZOEDATA_LAB | Date: 2025-10-19
-- Notes: Campos clave opcionales (provisionados) ya consolidados como NULLABLE.

CREATE TABLE companies (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE RESTRICT,
  legal_name       TEXT NULL,                 -- provisionadas permiten NULL
  tax_id           TEXT NULL,                 -- RUC opcional
  contact_email    public.citext NULL,        -- provisionadas permiten NULL
  contact_phone    TEXT NULL,
  district_id      UUID NULL REFERENCES catalog_district(id) ON DELETE SET NULL,
  profile_complete BOOLEAN NOT NULL DEFAULT FALSE,
  active           BOOLEAN NOT NULL DEFAULT TRUE,
  suspended        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by       UUID NULL,
  updated_by       UUID NULL
);

CREATE INDEX ix_companies__active    ON companies(active);
CREATE INDEX ix_companies__suspended ON companies(suspended);

-- Unicidad case-insensitive de tax_id, permitiendo múltiples NULL
CREATE UNIQUE INDEX ux_companies__taxid_ci
  ON companies (lower(tax_id))
  WHERE tax_id IS NOT NULL;

CREATE TRIGGER trg_companies__updated_at
  BEFORE UPDATE ON companies FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE companies IS 'Perfil de empresa (1:1 con users).';
