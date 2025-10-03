-- Purpose: Outbox for transactional emails (future-proof)
-- Author: ZOEDATA_LAB | Date: 2025-09-23

CREATE TABLE notifications_outbox (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type TEXT NOT NULL, -- e.g., 'JOB_PUBLISHED','APPLICATION_RECEIVED','APPLICATION_STATUS_CHANGED'
  payload JSONB NOT NULL, -- contains recipient email(s) and template data
  status TEXT NOT NULL CHECK (status IN ('PENDING','SENT','FAILED')) DEFAULT 'PENDING',
  attempts INT NOT NULL DEFAULT 0,
  last_error TEXT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_outbox_status ON notifications_outbox(status);
CREATE TRIGGER trg_outbox_updated_at BEFORE UPDATE ON notifications_outbox FOR EACH ROW EXECUTE FUNCTION set_updated_at();
