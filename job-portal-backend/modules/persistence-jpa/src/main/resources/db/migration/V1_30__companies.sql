-- Purpose: Company profiles
-- Author: ZOEDATA_LAB | Date: 2025-09-23

CREATE TABLE companies (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE RESTRICT,
  legal_name TEXT NOT NULL,
  tax_id TEXT NULL, -- RUC opcional
  contact_email public.citext NOT NULL,
  contact_phone TEXT NULL,
  district_id UUID NULL REFERENCES catalog_district(id) ON DELETE SET NULL,
  profile_complete BOOLEAN NOT NULL DEFAULT FALSE,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  suspended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by UUID NULL,
  updated_by UUID NULL
);
CREATE INDEX idx_companies_active ON companies(active);
CREATE INDEX idx_companies_suspended ON companies(suspended);
CREATE TRIGGER trg_companies_updated_at BEFORE UPDATE ON companies FOR EACH ROW EXECUTE FUNCTION set_updated_at();
