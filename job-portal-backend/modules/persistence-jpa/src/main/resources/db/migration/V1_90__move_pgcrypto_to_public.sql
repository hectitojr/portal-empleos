-- Purpose: Move pgcrypto extension to public schema
-- Author: ZOEDATA_LAB | Date: 2025-10-01

DO $$
DECLARE
  current_schema text;
BEGIN
  SELECT n.nspname INTO current_schema
  FROM pg_extension e
  JOIN pg_namespace n ON n.oid = e.extnamespace
  WHERE e.extname = 'pgcrypto';

  IF current_schema IS DISTINCT FROM 'public' THEN
    ALTER EXTENSION pgcrypto SET SCHEMA public;
  END IF;
END
$$;
