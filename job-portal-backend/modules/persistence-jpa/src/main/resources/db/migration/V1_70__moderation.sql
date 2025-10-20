-- File: V1_70__moderation.sql
-- Title: Moderation actions
-- Purpose: Historial de acciones de moderación.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

CREATE TABLE moderation_actions (
  id          UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  target_type TEXT NOT NULL CHECK (target_type IN ('JOB','USER')),
  target_id   UUID NOT NULL,
  reason      TEXT NOT NULL,
  created_by  UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT, -- admin
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX ix_moderation_actions__target ON moderation_actions(target_type, target_id);

COMMENT ON TABLE moderation_actions IS 'Acciones de moderación (JOB/USER).';
