-- Purpose: Moderation actions
-- Author: ZOEDATA_LAB | Date: 2025-09-23

CREATE TABLE moderation_actions (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  target_type TEXT NOT NULL CHECK (target_type IN ('JOB','USER')),
  target_id UUID NOT NULL,
  reason TEXT NOT NULL,
  created_by UUID NOT NULL REFERENCES users(id) ON DELETE RESTRICT, -- admin
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_moderation_target ON moderation_actions(target_type, target_id);
