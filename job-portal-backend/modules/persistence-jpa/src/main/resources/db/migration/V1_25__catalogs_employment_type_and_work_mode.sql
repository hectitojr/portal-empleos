--File:V1_25__catalogs_employment_type_and_work_mode.sql
--Title:Controlled vocabularies (employment_type, work_mode)
--Purpose:Tablas de catálogos para tipo de empleo y modalidad de trabajo usadas en UI de ofertas.
--Author:ZOEDATA_LAB|Date:2025-11-24
--Notes:Se crean siguiendo el patrón de V1_20__catalogs.sql.

CREATE TABLE catalog_employment_type (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE catalog_work_mode (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL UNIQUE,
  active BOOLEAN NOT NULL DEFAULT TRUE
);

COMMENT ON TABLE catalog_employment_type IS 'Tipos de empleo (p.ej., tiempo completo, part - time, contrato, prácticas, etc.).';
COMMENT ON TABLE catalog_work_mode IS 'Modalidad de trabajo (p.ej., presencial, remoto, híbrido, campo).';