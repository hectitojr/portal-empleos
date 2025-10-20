-- File: R__catalog_seed.sql
-- Title: Seed catalogs (MVP)
-- Purpose: Cargar datos mínimos para filtros; idempotente.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

-- ÁREAS
INSERT INTO catalog_area (id, name) VALUES
  (gen_random_uuid(), 'Tecnología'),
  (gen_random_uuid(), 'Ventas'),
  (gen_random_uuid(), 'Administración')
ON CONFLICT DO NOTHING;

-- SECTORES
INSERT INTO catalog_sector (id, name) VALUES
  (gen_random_uuid(), 'Finanzas'),
  (gen_random_uuid(), 'Retail'),
  (gen_random_uuid(), 'Salud')
ON CONFLICT DO NOTHING;

-- DISTRITOS
INSERT INTO catalog_district (id, name) VALUES
  (gen_random_uuid(), 'Lima'),
  (gen_random_uuid(), 'Miraflores'),
  (gen_random_uuid(), 'San Isidro')
ON CONFLICT DO NOTHING;

-- DISCAPACIDADES
INSERT INTO catalog_disability_type (id, name) VALUES
  (gen_random_uuid(), 'Visual'),
  (gen_random_uuid(), 'Auditiva'),
  (gen_random_uuid(), 'Motriz')
ON CONFLICT DO NOTHING;
