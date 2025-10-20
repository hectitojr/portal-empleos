-- File: V1_20__catalogs.sql
-- Title: Controlled vocabularies (areas, sectors, districts, disability types)
-- Purpose: Tablas de catálogos para filtros de búsqueda.
-- Author: ZOEDATA_LAB | Date: 2025-10-19

CREATE TABLE catalog_area (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE catalog_sector (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE catalog_district (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE catalog_disability_type (
  id     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name   TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

COMMENT ON TABLE catalog_area IS 'Áreas funcionales (p.ej., Tecnología, Ventas).';
COMMENT ON TABLE catalog_sector IS 'Sector económico (p.ej., Finanzas, Retail).';
COMMENT ON TABLE catalog_district IS 'Distritos/zonas geográficas.';
COMMENT ON TABLE catalog_disability_type IS 'Tipos de discapacidad.';
