-- File: V1_56__job_offers_indexes.sql
-- Title: Job offers search indexes
-- Purpose: Optimizar búsquedas públicas y por postulante
--          (área, sector, distrito, discapacidad y orden por fecha).
-- Author: ZOEDATA_LAB | Date: 2025-12-18

-------------------------
-- 1) JOB_OFFERS: filtros principales
-------------------------

-- Filtro por área
CREATE INDEX IF NOT EXISTS ix_job_offers__area
  ON job_offers(area_id);

-- Filtro por sector
CREATE INDEX IF NOT EXISTS ix_job_offers__sector
  ON job_offers(sector_id);

-- Filtro directo por distrito (caso más específico)
CREATE INDEX IF NOT EXISTS ix_job_offers__district
  ON job_offers(district_id);

-- Filtro por discapacidad
CREATE INDEX IF NOT EXISTS ix_job_offers__disability_friendly
  ON job_offers(disability_friendly);

-- Orden por fecha de publicación
CREATE INDEX IF NOT EXISTS ix_job_offers__published_at
  ON job_offers(published_at DESC);

-------------------------
-- 2) JOB_OFFERS: combinaciones frecuentes
-------------------------

-- Búsqueda típica: sector + distrito + fecha
CREATE INDEX IF NOT EXISTS ix_job_offers__sector_district_published
  ON job_offers(sector_id, district_id, published_at DESC);

-- Búsqueda típica: área + fecha
CREATE INDEX IF NOT EXISTS ix_job_offers__area_published
  ON job_offers(area_id, published_at DESC);

-------------------------
-- 3) COMMENTS
-------------------------

COMMENT ON INDEX ix_job_offers__area
  IS 'Filtro por área funcional en búsquedas de ofertas.';

COMMENT ON INDEX ix_job_offers__sector
  IS 'Filtro por sector económico en búsquedas de ofertas.';

COMMENT ON INDEX ix_job_offers__district
  IS 'Filtro directo por distrito (máxima precisión geográfica).';

COMMENT ON INDEX ix_job_offers__disability_friendly
  IS 'Filtro booleano para ofertas inclusivas.';

COMMENT ON INDEX ix_job_offers__published_at
  IS 'Ordenamiento descendente por fecha de publicación.';

COMMENT ON INDEX ix_job_offers__sector_district_published
  IS 'Índice compuesto para búsquedas por sector + distrito + fecha.';

COMMENT ON INDEX ix_job_offers__area_published
  IS 'Índice compuesto para búsquedas por área + fecha.';
