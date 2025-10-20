-- File: V1_00__extensions_and_baseline.sql
-- Title: Extensions & Baseline (pgcrypto, citext) + updated_at helper
-- Purpose: Habilitar extensiones requeridas y función/trigger base de updated_at.
-- Author: ZOEDATA_LAB | Date: 2025-10-19
-- Notes: Extensiones en esquema public; archivos posteriores asumen su existencia.

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;  -- gen_random_uuid()
CREATE EXTENSION IF NOT EXISTS citext   WITH SCHEMA public;  -- case-insensitive text

-- Helper: set_updated_at() para timestamps consistentes
CREATE OR REPLACE FUNCTION set_updated_at() RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;