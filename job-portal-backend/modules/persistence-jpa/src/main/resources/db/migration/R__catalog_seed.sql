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
  ('7f8a0c0d-58f6-4d7b-9c1e-1f0d8d2f4c01', 'Visual', TRUE),
  ('e2c6f7a1-7a54-4f08-a5b0-3e2b7b5f1a02', 'Auditiva', TRUE),
  ('3b6b8cf0-4f2c-4d0f-8a9a-0d2c3b4a5f03', 'Física / Motora', TRUE),
  ('a7c3d2f1-8b7a-4d2c-9a1b-2c3d4e5f6a04', 'Intelectual', TRUE),
  ('d9f1a2b3-6c7d-4e5f-8a9b-1c2d3e4f5a05', 'Psicosocial', TRUE)
ON CONFLICT (name) DO UPDATE
SET active = EXCLUDED.active;

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
