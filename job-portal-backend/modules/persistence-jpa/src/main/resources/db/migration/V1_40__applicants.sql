-- Purpose: Applicant profiles (as CV)
-- Author: ZOEDATA_LAB | Date: 2025-09-23

CREATE TABLE applicants (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id UUID NOT NULL UNIQUE REFERENCES users(id) ON DELETE RESTRICT,
  full_name TEXT NOT NULL,
  contact_email public.citext NOT NULL,
  contact_phone TEXT NULL,
  district_id UUID NULL REFERENCES catalog_district(id) ON DELETE SET NULL,
  profile_summary TEXT NULL,
  profile_complete BOOLEAN NOT NULL DEFAULT FALSE,
  active BOOLEAN NOT NULL DEFAULT TRUE,
  suspended BOOLEAN NOT NULL DEFAULT FALSE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by UUID NULL,
  updated_by UUID NULL
);
CREATE TRIGGER trg_applicants_updated_at BEFORE UPDATE ON applicants FOR EACH ROW EXECUTE FUNCTION set_updated_at();

CREATE TABLE applicant_experience (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  applicant_id UUID NOT NULL REFERENCES applicants(id) ON DELETE CASCADE,
  company TEXT NOT NULL,
  role TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NULL,
  description TEXT NULL
);
CREATE INDEX idx_exp_applicant ON applicant_experience(applicant_id);

CREATE TABLE applicant_education (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  applicant_id UUID NOT NULL REFERENCES applicants(id) ON DELETE CASCADE,
  institution TEXT NOT NULL,
  degree TEXT NOT NULL,
  start_date DATE NOT NULL,
  end_date DATE NULL,
  description TEXT NULL
);
CREATE INDEX idx_edu_applicant ON applicant_education(applicant_id);

CREATE TABLE applicant_skill (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  applicant_id UUID NOT NULL REFERENCES applicants(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  level TEXT NULL
);
CREATE UNIQUE INDEX uq_skill_per_applicant ON applicant_skill(applicant_id, name);

CREATE TABLE applicant_disability (
  applicant_id UUID NOT NULL REFERENCES applicants(id) ON DELETE CASCADE,
  disability_id UUID NOT NULL REFERENCES catalog_disability_type(id) ON DELETE RESTRICT,
  PRIMARY KEY (applicant_id, disability_id)
);
