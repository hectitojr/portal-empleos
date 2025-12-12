-- File: V1_20__catalogs.sql
-- Title: Controlled vocabularies (areas, sectors, location, disability types)
-- Purpose: Tablas de catálogos para filtros de búsqueda (áreas, sectores, jerarquía geográfica y discapacidad).
-- Author: ZOEDATA_LAB | Date: 2025-10-19 (updated 2025-12-08)

-------------------------
-- ÁREAS
-------------------------
CREATE TABLE catalog_area (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

-------------------------
-- SECTORES
-------------------------
CREATE TABLE catalog_sector (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

-------------------------
-- GEOGRAFÍA: DEPARTAMENTO / PROVINCIA / DISTRITO
-------------------------

CREATE TABLE catalog_department (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE catalog_province (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id UUID NOT NULL REFERENCES catalog_department(id) ON DELETE RESTRICT,
  name          TEXT NOT NULL,
  active        BOOLEAN NOT NULL DEFAULT TRUE,
  UNIQUE (department_id, name)
);

CREATE TABLE catalog_district (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  department_id UUID NOT NULL REFERENCES catalog_department(id) ON DELETE RESTRICT,
  province_id   UUID NOT NULL REFERENCES catalog_province(id)   ON DELETE RESTRICT,
  name          TEXT NOT NULL,
  active        BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT uq_catalog_district__province_name UNIQUE (province_id, name)
);

-- Índices para jerarquía geográfica (producción)
CREATE INDEX ix_catalog_province__department
  ON catalog_province(department_id);

CREATE INDEX ix_catalog_district__province
  ON catalog_district(province_id);

CREATE INDEX ix_catalog_district__department
  ON catalog_district(department_id);

-------------------------
-- DISCAPACIDADES
-------------------------
CREATE TABLE catalog_disability_type (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

-------------------------
-- COMMENTS
-------------------------
COMMENT ON TABLE catalog_area            IS 'Áreas funcionales (p.ej., Tecnología, Ventas).';
COMMENT ON TABLE catalog_sector          IS 'Sector económico (p.ej., Finanzas, Retail).';
COMMENT ON TABLE catalog_department      IS 'Departamentos del país (p.ej., Lima, Arequipa, Cusco).';
COMMENT ON TABLE catalog_province        IS 'Provincias por departamento (p.ej., Lima, Huarochirí, Arequipa).';
COMMENT ON TABLE catalog_district        IS 'Distritos/zonas geográficas, vinculados a provincia y departamento.';
COMMENT ON TABLE catalog_disability_type IS 'Tipos de discapacidad.';
