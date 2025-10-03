-- Purpose: Enable required extensions and set baseline structures.
-- Author: ZOEDATA_LAB | Date: 2025-09-23

CREATE EXTENSION IF NOT EXISTS pgcrypto; -- gen_random_uuid()

-- Common updated_at auto-update trigger
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
