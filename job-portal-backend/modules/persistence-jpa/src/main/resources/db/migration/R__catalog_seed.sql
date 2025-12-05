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

--TIPOS DE EMPLEO
INSERT INTO catalog_employment_type(id, name) VALUES
  (gen_random_uuid(), 'Tiempo Completo'),
  (gen_random_uuid(), 'Tiempo Parcial'),
  (gen_random_uuid(), 'Por Contrato'),
  (gen_random_uuid(), 'Prácticas Pre-profesionales'),
  (gen_random_uuid(), 'Prácticas Profesionales'),
  (gen_random_uuid(), 'Freelance'),
  (gen_random_uuid(), 'Contrato indefinido')
ON CONFLICT DO NOTHING;

--MODALIDAD DE TRABAJO
INSERT INTO catalog_work_mode(id, name) VALUES
(gen_random_uuid(), 'Presencial'),
(gen_random_uuid(), 'Remoto'),
(gen_random_uuid(), 'Híbrido'),
(gen_random_uuid(), 'Campo')
ON CONFLICT DO NOTHING;

