-- File: V1_80__notifications_outbox.sql
-- Title: Notifications outbox
-- Purpose: Outbox para emails/eventos transaccionales.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

CREATE TABLE notifications_outbox (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  type       TEXT NOT NULL,          -- e.g., 'JOB_PUBLISHED','APPLICATION_RECEIVED','APPLICATION_STATUS_CHANGED'
  payload    JSONB NOT NULL,         -- destinatarios/datos de plantilla
  status     TEXT NOT NULL CHECK (status IN ('PENDING','SENT','FAILED')) DEFAULT 'PENDING',
  attempts   INT NOT NULL DEFAULT 0,
  last_error TEXT NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX ix_notifications_outbox__status ON notifications_outbox(status);

CREATE TRIGGER trg_notifications_outbox__updated_at
  BEFORE UPDATE ON notifications_outbox FOR EACH ROW EXECUTE FUNCTION set_updated_at();

COMMENT ON TABLE notifications_outbox IS 'Patrón Outbox para notificaciones.';
