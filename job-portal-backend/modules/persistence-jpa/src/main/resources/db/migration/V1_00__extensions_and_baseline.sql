-- File: V1_00__extensions_and_baseline.sql
-- Title: Extensions & Baseline (pgcrypto, citext, pg_trgm) + updated_at helper
-- Purpose: Habilitar extensiones requeridas y función base de updated_at.
-- Author: ZOEDATA_LAB

SET search_path TO job_portal, public;

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS citext   WITH SCHEMA public;
CREATE EXTENSION IF NOT EXISTS pg_trgm  WITH SCHEMA public;
COMMENT ON EXTENSION pg_trgm IS 'Trigram matching support';

CREATE OR REPLACE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;
