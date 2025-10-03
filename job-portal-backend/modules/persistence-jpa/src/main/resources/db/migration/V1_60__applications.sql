-- Purpose: Applications (candidate -> job)
-- Author: ZOEDATA_LAB | Date: 2025-09-23

CREATE TABLE applications (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_id UUID NOT NULL REFERENCES job_offers(id) ON DELETE RESTRICT,
  applicant_id UUID NOT NULL REFERENCES applicants(id) ON DELETE RESTRICT,
  status TEXT NOT NULL CHECK (status IN ('APPLIED','IN_REVIEW','SHORTLISTED','HIRED','REJECTED')) DEFAULT 'APPLIED',
  notes TEXT NULL,
  applied_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  created_by UUID NULL,
  updated_by UUID NULL
);
CREATE UNIQUE INDEX uq_applications_job_applicant ON applications(job_id, applicant_id);
CREATE INDEX idx_applications_job ON applications(job_id);
CREATE INDEX idx_applications_applicant ON applications(applicant_id);
CREATE INDEX idx_applications_status ON applications(status);
CREATE TRIGGER trg_applications_updated_at BEFORE UPDATE ON applications FOR EACH ROW EXECUTE FUNCTION set_updated_at();
