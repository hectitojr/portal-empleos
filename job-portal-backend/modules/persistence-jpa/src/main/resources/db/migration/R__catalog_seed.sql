-- File: R__catalog_seed.sql
-- Title: Seed catalogs (MVP)
-- Purpose: Cargar catálogos funcionales mínimos; idempotente.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

-------------------------
-- ÁREAS
-------------------------
INSERT INTO catalog_area (id, name, active) VALUES
  (gen_random_uuid(), 'Tecnología',     TRUE),
  (gen_random_uuid(), 'Ventas',         TRUE),
  (gen_random_uuid(), 'Administración', TRUE)
ON CONFLICT (name) DO NOTHING;

-------------------------
-- SECTORES
-------------------------
INSERT INTO catalog_sector (id, name, active) VALUES
  (gen_random_uuid(), 'Finanzas', TRUE),
  (gen_random_uuid(), 'Retail',   TRUE),
  (gen_random_uuid(), 'Salud',    TRUE)
ON CONFLICT (name) DO NOTHING;

-------------------------
-- DISCAPACIDADES
-------------------------
INSERT INTO catalog_disability_type (id, name, active) VALUES
  (gen_random_uuid(), 'Visual',   TRUE),
  (gen_random_uuid(), 'Auditiva', TRUE),
  (gen_random_uuid(), 'Motriz',   TRUE)
ON CONFLICT (name) DO NOTHING;

-------------------------
-- TIPOS DE EMPLEO
-------------------------
INSERT INTO catalog_employment_type (id, name, active) VALUES
  (gen_random_uuid(), 'Tiempo Completo',              TRUE),
  (gen_random_uuid(), 'Tiempo Parcial',               TRUE),
  (gen_random_uuid(), 'Por Contrato',                 TRUE),
  (gen_random_uuid(), 'Prácticas Pre-profesionales',  TRUE),
  (gen_random_uuid(), 'Prácticas Profesionales',      TRUE),
  (gen_random_uuid(), 'Freelance',                    TRUE),
  (gen_random_uuid(), 'Contrato indefinido',          TRUE)
ON CONFLICT (name) DO NOTHING;

-------------------------
-- MODALIDADES DE TRABAJO
-------------------------
INSERT INTO catalog_work_mode (id, name, active) VALUES
  (gen_random_uuid(), 'Presencial', TRUE),
  (gen_random_uuid(), 'Remoto',     TRUE),
  (gen_random_uuid(), 'Híbrido',    TRUE),
  (gen_random_uuid(), 'Campo',      TRUE)
ON CONFLICT (name) DO NOTHING;
