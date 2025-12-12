-- File: R__location_seed_peru.sql
-- Title: Seed full Peru location hierarchy
-- Purpose: Cargar catálogo completo oficial de Perú
--          (Departamentos → Provincias → Distritos).
-- Author: ZOEDATA_LAB | Generated automatically
-- Notes:
--   - Idempotente (ON CONFLICT).
--   - Determinista (ordenado).
--   - Normalización a Title Case en español.

-------------------------
-- 1) DEPARTAMENTOS
-------------------------
INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Amazonas', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Ancash', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Apurimac', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Arequipa', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Ayacucho', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Cajamarca', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Callao', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Cusco', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Huancavelica', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Huanuco', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Ica', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Junin', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'La Libertad', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Lambayeque', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Lima', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Loreto', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Madre de Dios', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Moquegua', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Pasco', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Piura', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Puno', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'San Martin', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Tacna', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Tumbes', TRUE)
ON CONFLICT (name) DO NOTHING;

INSERT INTO catalog_department (id, name, active)
VALUES (gen_random_uuid(), 'Ucayali', TRUE)
ON CONFLICT (name) DO NOTHING;

-------------------------
-- 2) PROVINCIAS
-------------------------
INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Bagua', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Bongara', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chachapoyas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Condorcanqui', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Luya', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Rodriguez de Mendoza', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Utcubamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Amazonas'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Aija', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Antonio Raymondi', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Asuncion', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Bolognesi', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Carhuaz', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Carlos Fermin Fitzcarrald', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Casma', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Corongo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huaraz', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huari', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huarmey', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huaylas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Mariscal Luzuriaga', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ocros', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pallasca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pomabamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Recuay', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Santa', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Sihuas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Yungay', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ancash'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Abancay', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Andahuaylas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Antabamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Aymaraes', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chincheros', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cotabambas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Grau', TRUE
FROM catalog_department dep
WHERE dep.name = 'Apurimac'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Arequipa', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Camana', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Caraveli', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Castilla', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Caylloma', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Condesuyos', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Islay', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'La Union', TRUE
FROM catalog_department dep
WHERE dep.name = 'Arequipa'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cangallo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huamanga', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huanca Sancos', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huanta', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'La Mar', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Lucanas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Parinacochas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Paucar del Sara Sara', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Sucre', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Victor Fajardo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Vilcas Huaman', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ayacucho'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cajabamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cajamarca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Celendin', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chota', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Contumaza', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cutervo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Hualgayoc', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Jaen', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Ignacio', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Marcos', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Miguel', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Pablo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Santa Cruz', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cajamarca'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Callao', TRUE
FROM catalog_department dep
WHERE dep.name = 'Callao'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Acomayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Anta', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Calca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Canas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Canchis', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chumbivilcas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cusco', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Espinar', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'La Convencion', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Paruro', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Paucartambo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Quispicanchi', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Urubamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Cusco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Acobamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Angaraes', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Castrovirreyna', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Churcampa', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huancavelica', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huaytara', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tayacaja', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huancavelica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ambo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Dos de Mayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huacaybamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huamalies', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huanuco', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Lauricocha', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Leoncio Prado', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Marañon', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pachitea', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Puerto Inca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Yarowilca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Huanuco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chincha', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ica', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Nasca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Palpa', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pisco', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ica'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chanchamayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chupaca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Concepcion', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huancayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Jauja', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Junin', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Satipo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tarma', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Yauli', TRUE
FROM catalog_department dep
WHERE dep.name = 'Junin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ascope', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Bolivar', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chepen', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Gran Chimu', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Julcan', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Otuzco', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pacasmayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pataz', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Sanchez Carrion', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Santiago de Chuco', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Trujillo', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Viru', TRUE
FROM catalog_department dep
WHERE dep.name = 'La Libertad'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chiclayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lambayeque'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ferreñafe', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lambayeque'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Lambayeque', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lambayeque'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Barranca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cajatambo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Canta', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Cañete', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huaral', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huarochiri', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huaura', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Lima', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Oyon', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Yauyos', TRUE
FROM catalog_department dep
WHERE dep.name = 'Lima'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Alto Amazonas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Datem del Marañon', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Loreto', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Mariscal Ramon Castilla', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Maynas', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Putumayo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Requena', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ucayali', TRUE
FROM catalog_department dep
WHERE dep.name = 'Loreto'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Manu', TRUE
FROM catalog_department dep
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tahuamanu', TRUE
FROM catalog_department dep
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tambopata', TRUE
FROM catalog_department dep
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'General Sanchez Cerro', TRUE
FROM catalog_department dep
WHERE dep.name = 'Moquegua'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ilo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Moquegua'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Mariscal Nieto', TRUE
FROM catalog_department dep
WHERE dep.name = 'Moquegua'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Daniel Alcides Carrion', TRUE
FROM catalog_department dep
WHERE dep.name = 'Pasco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Oxapampa', TRUE
FROM catalog_department dep
WHERE dep.name = 'Pasco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Pasco', TRUE
FROM catalog_department dep
WHERE dep.name = 'Pasco'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Ayabaca', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huancabamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Morropon', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Paita', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Piura', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Sechura', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Sullana', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Talara', TRUE
FROM catalog_department dep
WHERE dep.name = 'Piura'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Azangaro', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Carabaya', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Chucuito', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'El Collao', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huancane', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Lampa', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Melgar', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Moho', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Puno', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Antonio de Putina', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Roman', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Sandia', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Yunguyo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Puno'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Bellavista', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'El Dorado', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Huallaga', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Lamas', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Mariscal Caceres', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Moyobamba', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Picota', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Rioja', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'San Martin', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tocache', TRUE
FROM catalog_department dep
WHERE dep.name = 'San Martin'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Candarave', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tacna'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Jorge Basadre', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tacna'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tacna', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tacna'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tarata', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tacna'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Contralmirante Villar', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tumbes'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Tumbes', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tumbes'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Zarumilla', TRUE
FROM catalog_department dep
WHERE dep.name = 'Tumbes'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Atalaya', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ucayali'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Coronel Portillo', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ucayali'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Padre Abad', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ucayali'
ON CONFLICT (department_id, name) DO NOTHING;

INSERT INTO catalog_province (id, department_id, name, active)
SELECT gen_random_uuid(), dep.id, 'Purus', TRUE
FROM catalog_department dep
WHERE dep.name = 'Ucayali'
ON CONFLICT (department_id, name) DO NOTHING;

-------------------------
-- 3) DISTRITOS
-------------------------
INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aramango', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bagua'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bagua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bagua'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Copallin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bagua'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Parco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bagua'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Imaza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bagua'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Peca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bagua'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chisquilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Churuja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Corosha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuispes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Florida', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jazan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jumbilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Recta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Carlos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shipasbamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Valera', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yambrasbamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bongara'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Asuncion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Balsas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chachapoyas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cheto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiliquin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chuquibamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Granada', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Jalca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Leimebamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Levanto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Magdalena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariscal Castilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Molinopampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Montevideo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Olleros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quinjalca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco de Daguas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Isidro de Maino', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Soloco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sonche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chachapoyas'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Cenepa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condorcanqui'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nieva', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condorcanqui'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rio Santiago', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condorcanqui'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Camporredondo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cocabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colcamar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conila', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Inguilpata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lamud', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Longuita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lonya Chico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Luya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Luya Viejo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Maria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocalli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocumal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pisuquia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Providencia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Cristobal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco del Yeso', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jeronimo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Lopecancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Catalina', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Tomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tingo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Trita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Luya'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chirimoto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochamal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Limabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Longar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariscal Benavides', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Milpuc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Omia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Nicolas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Totora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vista Alegre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rodriguez de Mendoza'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bagua Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajaruro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cumba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Milagro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jamalca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lonya Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yamon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Utcubamba'
WHERE dep.name = 'Amazonas'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aija', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aija'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coris', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aija'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacllan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aija'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Merced', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aija'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Succha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aija'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aczo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antonio Raymondi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaccho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antonio Raymondi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chingas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antonio Raymondi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llamellin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antonio Raymondi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mirgas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antonio Raymondi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Rontoy', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antonio Raymondi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acochaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Asuncion'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chacas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Asuncion'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Abelardo Pardo Lezameta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Antonio Raymondi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aquia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajacay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiquian', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colquioc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huallanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huasta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllacayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Primavera', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mangas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacllon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de Corpanqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ticllos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolognesi'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acopampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Amashca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ataquero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carhuaz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pariahuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de Aco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tinco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yungar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carhuaz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Luis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carlos Fermin Fitzcarrald'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Nicolas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carlos Fermin Fitzcarrald'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carlos Fermin Fitzcarrald'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Buena Vista Alta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Casma'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Casma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Casma'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Comandante Noel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Casma'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yautan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Casma'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bambas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Corongo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cusca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Pampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yupan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Corongo'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanchay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaraz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Independencia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jangas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Libertad', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Olleros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampas Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pariacoto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pira', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tarica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaraz'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chavin de Huantar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacchis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huantar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Masin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ponto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rahuapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rapayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Marcos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Chana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huari'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochapeti', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarmey'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Culebras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarmey'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huarmey', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarmey'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarmey'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Malvas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarmey'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caraz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huallanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaylas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mato', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pamparomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Libre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Toribio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yuracmarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaylas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Casca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Eleazar Guzman Barron', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Fidel Olivas Escudero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llumpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lucma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Musga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Piscobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Luzuriaga'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajamarquilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carhuapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Congas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llipa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Cristobal de Rajan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Chilcas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ocros'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bolognesi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cabana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conchucos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacaschuque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huandoval', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lacabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llapo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pallasca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tauca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pallasca'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pomabamba'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Parobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pomabamba'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pomabamba'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quinuabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pomabamba'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Catac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cotaparaco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llacllin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampas Chico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pararin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Recuay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tapacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ticapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Recuay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caceres del Peru', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chimbote', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coishco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Macate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Moro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nepeña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nuevo Chimbote', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Samanco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alfonso Ugarte', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cashapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chingalpo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quiches', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ragash', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sicsibamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sihuas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sihuas'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cascapara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mancos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Matacoto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ranrahirca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shupluy', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yungay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yungay'
WHERE dep.name = 'Ancash'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Abancay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chacoche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Circa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanipaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lambrama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pichirhua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Cachora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tamburco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Abancay'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andahuaylas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andarapa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancarama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancaray', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Maria Arguedas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kaquiabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kishuara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacucha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampachiri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio de Cachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jeronimo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de Chaccrampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Maria de Chicmo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Talavera', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tumay Huaraca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Turpo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Andahuaylas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Antabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Oro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaquirca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Juan Espinoza Medrano', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oropesa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachaconas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sabaino', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Antabamba'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Capaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caraybamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chalhuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chapimarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cotaruse', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ihuayllo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Justo Apu Sahuaraura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lucre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pocohuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Chacña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sañayca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Soraya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tapairihua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tintay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Toraya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Aymaraes'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ahuayro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anco_huallo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chincheros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cocharcas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Porvenir', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaccana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Los Chankas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ongoy', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ranracancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rocchacc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uranmarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincheros'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Challhuahuacho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cotabambas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cotabambas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cotabambas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coyllurqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cotabambas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Haquira', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cotabambas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cotabambas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cotabambas'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chuquibambilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curasco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curpahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Gamarra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllati', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mamara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Micaela Bastidas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pataypampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Progreso', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Turpay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Virundo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Grau'
WHERE dep.name = 'Apurimac'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Selva Alegre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Arequipa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cayma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cerro Colorado', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Characato', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiguata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jacobo Hunter', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Luis Bustamante y Rivero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Joya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariano Melgar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miraflores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mollebaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucarpata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pocsi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Polobaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quequeña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sabandia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sachaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Siguas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Tarucani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Isabel de Siguas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rita de Siguas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Socabaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tiabaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uchumayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vitor', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanahuara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yarabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Arequipa'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Camana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Maria Quimper', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariano Nicolas Valcarcel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariscal Caceres', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nicolas de Pierola', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocoña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Samuel Pastor', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Camana'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Atico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Atiquipa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bella Union', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cahuacho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caraveli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chala', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaparra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanuhuanu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jaqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quicacha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caraveli'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andagua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aplao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chachas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chilcaymarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Choco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancarqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Machaguay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Orcopampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampacolca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tipan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uraca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uñon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Viraco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castilla'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Achoma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cabanaconde', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Callalli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caylloma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chivay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coporaque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ichupampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lluta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Maca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Madrigal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Majes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio de Chuca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sibayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tapay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tisco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tuti', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Caylloma'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andaray', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cayarani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chichas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chuquibamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Iray', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rio Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salamanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanaquihua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Condesuyos'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cocachacra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Islay'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Dean Valdivia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Islay'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Islay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Islay'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mejia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Islay'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mollendo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Islay'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Punta de Bombon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Islay'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Charcana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cotahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaynacotas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puyca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quechualla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sayla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tauria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tomepampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Toro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Union'
WHERE dep.name = 'Arequipa'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cangallo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cangallo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chuschi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cangallo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Los Morochucos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cangallo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Maria Parado de Bellido', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cangallo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cangallo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Totos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cangallo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acocro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acos Vinchos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andres Avelino Caceres Dorregaray', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayacucho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carmen Alto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jesus Nazareno', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacaycasa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quinua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose de Ticllas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan Bautista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Pischa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Socos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vinchos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamanga'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carapo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanca Sancos'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sacsamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanca Sancos'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sancos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanca Sancos'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Lucanamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanca Sancos'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayahuanco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canayre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamanguilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Iguain', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llochegua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Luricocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucacolpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Putis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santillana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sivia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uchuraccay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanta'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anchihuay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayna', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chilcas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chungui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Luis Carranza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ninabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oronccoy', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Patibamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rio Magdalena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Samugari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Union Progreso', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Mar'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aucara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cabana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carmen Salcedo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaviña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chipao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huac-huas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Laramate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Leoncio Prado', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llauta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lucanas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocaña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Otoca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puquio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saisa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Cristobal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Palco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sancos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Ana de Huaycahuacho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Lucia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lucanas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chumpi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coracora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coronel Castañeda', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacapausa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pullo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puyusca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco de Rivacayco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Upahuacho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Parinacochas'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Corculla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oyolo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pararca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pausa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Javier de Alpabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose de Ushua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sara Sara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucar del Sara Sara'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Belen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chalcos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chilcayoc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacaña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Morcolla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Querobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Larcay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Salvador de Quije', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Paucaray', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Soras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sucre'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alcamenca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Apongo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Asquipata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canaria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cayara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Hualla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamanquiquia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancapi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancaraylla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sarhua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilcanchos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Victor Fajardo'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Accomarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carhuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Concepcion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huambalpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Independencia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saurama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilcas Huaman', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vischongo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Vilcas Huaman'
WHERE dep.name = 'Ayacucho'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cachachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajabamba'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajabamba'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Condebamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajabamba'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sitacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajabamba'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Asuncion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chetilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cospan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Encañada', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jesus', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llacanora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Los Baños del Inca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Magdalena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Matara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Namora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajamarca'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Celendin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chumuch', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cortegana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huasmin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jorge Chavez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Galvez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Libertad de Pallan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miguel Iglesias', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oxamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sorochuco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sucre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Utco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Celendin'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anguia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chadin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chalamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiguirip', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chimban', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Choropampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chota', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conchan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huambos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lajas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miracosta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paccha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Querocoto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Licupis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tacabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tocmoche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chota'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chilete', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Contumaza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cupisnique', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Guzmango', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Benito', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz de Toled', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tantarica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yonan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contumaza'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Callayuc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Choros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cujillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cutervo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Ramada', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pimpingos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Querocotillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Andres de Cutervo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Cutervo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Luis de Lucma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Domingo de la Capilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Tomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Socota', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Toribio Casanova', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cutervo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bambamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Hualgayoc'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chugur', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Hualgayoc'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Hualgayoc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Hualgayoc'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bellavista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chontali', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colasay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huabal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jaen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Las Pirias', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomahuaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sallique', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Felipe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose del Alto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jaen'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chirinos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huarango', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Coipa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Namballe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Ignacio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose de Lourdes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tabaconas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Ignacio'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chancay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Eduardo Villanueva', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Gregorio Pita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ichocan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Manuel Quiroz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Sabogal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pedro Galvez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Marcos'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bolivar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calquis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Catilluc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Prado', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Florida', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llapa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nanchoc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Niepos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Gregorio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Silvestre de Cochan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tongod', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Union Agua Blanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Miguel'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Bernardino', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Pablo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Luis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Pablo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pablo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Pablo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tumbaden', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Pablo'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Catache', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chancaybaños', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Esperanza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ninabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pulan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saucepampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sexi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uticyacu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauyucan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santa Cruz'
WHERE dep.name = 'Cajamarca'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bellavista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Callao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carmen de la Legua Reynoso', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Perla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Punta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mi Peru', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ventanilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Callao'
WHERE dep.name = 'Callao'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acomayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acopia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mosoc Llacta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomacanchi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rondocan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sangarara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acomayo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ancahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cachimayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chinchaypujio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huarocondo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Limatambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mollepata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucyura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Zurite', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Anta'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lamay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lares', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pisac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Salvador', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Taray', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanatile', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Calca'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Checca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kunturkanki', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Langui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Layo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quehue', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tupac Amaru', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanaoca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Checacupe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Combapata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marangani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pitumarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pablo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sicuani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tinta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canchis'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Capacmarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chamaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colquemarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Livitaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llusco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quiñota', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Tomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Velille', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chumbivilcas'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ccorca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cusco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Poroy', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jeronimo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Sebastian', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saylla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Wanchaq', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cusco'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Pichigua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Condoroma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coporaque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Espinar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocoruro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pallpata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pichigua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Suyckutambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Espinar'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cielo Punco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Echarate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayopata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Inkawasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kimbiri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kumpirushiato', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manitea', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Maranura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Megantoni', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pichari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quellouno', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Ana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Teresa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Union Ashaninka', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Villa Kintiarina', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Villa Virgen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'La Convencion'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Accha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ccapi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colcha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanoquite', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Omacha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paccaritambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paruro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pillpinto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yaurisque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paruro'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caicay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucartambo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Challabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucartambo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colquepata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucartambo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancarani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucartambo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kosñipata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucartambo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucartambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paucartambo'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andahuaylillas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Camanti', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ccarhuayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ccatca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cusipata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lucre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcapata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocongate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oropesa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quiquijana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Urcos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Quispicanchi'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chinchero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Machupicchu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Maras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ollantaytambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Urubamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yucay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Urubamba'
WHERE dep.name = 'Cusco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rosario', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Acobamba'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anchonga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Callanmarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ccochaccasa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chincho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Congalla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanca-huanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllay Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Julcamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lircay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio de Antaparco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Tomas de Pata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Secclla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Angaraes'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Arma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aurahua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Capillas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Castrovirreyna', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chupamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cocas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamatambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mollepampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Ana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tantara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ticrapo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Castrovirreyna'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chinchihuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Churcampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cosme', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Carmen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Merced', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Locroja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucarbamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de Mayocc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Coris', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Churcampa'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acobambilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acoria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ascension', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conayca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuenca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachocolpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancavelica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huando', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllahuara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Izcuchaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Laria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariscal Caceres', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Moya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nuevo Occoro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pilchaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancavelica'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayavi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cordova', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayacundo Arma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaytara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Laramarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocoyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pilpichaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Querco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quito-arma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio de Cusicancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco de Sangayaico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Isidro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Chocorvos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Quirahuara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Domingo de Capillas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaytara'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acostambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acraquia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ahuaycha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andaymarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Daniel Hernandez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachocolpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaribamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lambras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pazos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pichos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quichuas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quishuar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Roble', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salcahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Marcos de Rocchac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Tucuma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Surcubamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tintay Puncu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ñahuimpuquio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tayacaja'
WHERE dep.name = 'Huancavelica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cayna', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colpas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conchamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Rafael', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tomay Kichwa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ambo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chuquis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Union', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marias', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quivilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ripan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shunqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sillapata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Dos de Mayo'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canchabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huacaybamba'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huacaybamba'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacaybamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huacaybamba'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pinra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huacaybamba'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Arancay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chavin de Pariarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jacas Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jircan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miraflores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Monzon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Punchao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puños', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Singa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tantamayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huamalies'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Amarilis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chinchao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Churubamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanuco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Margos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pillco Marca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quisqui (kichki)', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco de Cayran', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pablo de Pillao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Chaulan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Maria del Valle', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yacus', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yarumayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huanuco'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Baños', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jesus', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jivia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Queropalca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rondos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco de Asis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de Cauri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lauricocha'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Castillo Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Daniel Alomia Robles', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Hermilio Valdizan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Crespo y Castillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Luyando', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariano Damaso Beraun', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucayacu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Nuevo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rupa-rupa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Domingo de Anda', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Leoncio Prado'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cholon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Marañon'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacrachuco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Marañon'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Morada', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Marañon'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Buenaventura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Marañon'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa de Alto Yanajanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Marañon'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaglla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pachitea'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Molino', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pachitea'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Panao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pachitea'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Umari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pachitea'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Codo del Pozuzo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puerto Inca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Honoria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puerto Inca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puerto Inca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puerto Inca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tournavista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puerto Inca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yuyapichis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puerto Inca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aparicio Pomares', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cahuac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chacabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chavinillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Choras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jacas Chico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Obas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yarowilca'
WHERE dep.name = 'Huanuco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Laran', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chavin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chincha Alta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chincha Baja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Carmen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Grocio Prado', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Nuevo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Yanac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Huacarpana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sunampe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambo de Mora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chincha'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Tinguiña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Los Aquijes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocucaje', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachacutec', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Parcona', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Nuevo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose de los Molinos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan Bautista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Subtanjalla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauca del Rosario', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ica'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Changuillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Nasca'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Ingenio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Nasca'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcona', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Nasca'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nasca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Nasca'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vista Alegre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Nasca'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llipata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Palpa'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Palpa'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rio Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Palpa'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Palpa'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tibillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Palpa'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancano', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Humay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Independencia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paracas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pisco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Andres', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Clemente', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tupac Amaru Inca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pisco'
WHERE dep.name = 'Ica'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chanchamayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chanchamayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Perene', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chanchamayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pichanaqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chanchamayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Luis de Shuaro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chanchamayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Ramon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chanchamayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vitoc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chanchamayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ahuac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chongos Bajo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chupaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamancaca Chico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Iscos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Jarpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tres de Diciembre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanacancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chupaca'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chambara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Comas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Concepcion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Heroinas Toledo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manzanares', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariscal Castilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Matahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mito', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nueve de Julio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Orcotuna', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose de Quero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa de Ocopa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Concepcion'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carhuacallanga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chacapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chicche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chongos Alto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chupuro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cullhuas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Tambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacrapuquio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Hualhuas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huasicancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayucachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ingenio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pariahuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pilcomayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quichuay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quilcas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Agustin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jeronimo de Tunan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Domingo de Acobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sapallanga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saño', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sicaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Viques', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancayo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acolla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Apata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ataura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canchayllo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curicaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Mantaro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamali', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaripampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huertas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Janjaillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jauja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Julcan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Leonor Ordoñez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llocllapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Masma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Masma Chicche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Molinos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Monobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Muqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Muquiyauyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paccha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pancan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Parco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomacancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ricran', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Lorenzo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Chunan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sausa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sincos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tunan Marca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauyos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jauja'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carhuamayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Junin'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Junin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Junin'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ondores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Junin'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ulcumayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Junin'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coviriali', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llaylla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mazamari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampa Hermosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pangoa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rio Negro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rio Tambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Satipo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vizcatán del Ene', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Satipo'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaricolca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huasahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Union', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palcamayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Cajas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tapo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tarma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarma'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chacapalpa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huay-huay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Oroya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcapomacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Morococha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paccha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Barbara de Carhuacayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa de Sacco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Suitucancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauli'
WHERE dep.name = 'Junin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ascope', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Casa Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chicama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chocope', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Magdalena de Cao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paijan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Razuri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Cao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ascope'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bambamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolivar'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bolivar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolivar'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Condormarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolivar'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Longotea', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolivar'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uchumarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolivar'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ucuncha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bolivar'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chepen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chepen'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacanga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chepen'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Nuevo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chepen'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cascas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Gran Chimu'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lucma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Gran Chimu'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marmot', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Gran Chimu'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sayapullo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Gran Chimu'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Julcan'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Julcan'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaso', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Julcan'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Julcan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Julcan'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Agallpampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Charat', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaranchal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Cuesta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mache', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Otuzco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paranday', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salpo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sinsicap', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Usquil', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Otuzco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Guadalupe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pacasmayo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jequetepeque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pacasmayo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacasmayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pacasmayo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pacasmayo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Lloc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pacasmayo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Buldibuyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chillia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancaspata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaylillas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ongon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Parcoy', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pataz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pias', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Challas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Taurija', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tayabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Urpay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pataz'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chugay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochorco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curgos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamachuco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcabal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sanagoran', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sarin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sartimbamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sanchez Carrion'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Angasmarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cachicadan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mollebamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mollepata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quiruvilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz de Chuca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Chuco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sitabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Santiago de Chuco'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Trujillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Porvenir', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Florencia de Mora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanchaco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Esperanza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Laredo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Moche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Poroto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salaverry', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Simbal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Trujillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Victor Larco Herrera', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Trujillo'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Viru'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Guadalupito', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Viru'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Viru', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Viru'
WHERE dep.name = 'La Libertad'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cayalti', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chiclayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chongoyape', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Eten', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Eten Puerto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Leonardo Ortiz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Victoria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lagunas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Monsefu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nueva Arica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oyotun', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Patapo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Picsi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pimentel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomalca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucala', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Reque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tuman', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chiclayo'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cañaris', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ferreñafe'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ferreñafe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ferreñafe'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Incahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ferreñafe'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manuel Antonio Mesones Muro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ferreñafe'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pitipo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ferreñafe'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Nuevo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ferreñafe'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chochope', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Illimo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jayanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lambayeque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mochumi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Morrope', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Motupe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Olmos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tucume', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lambayeque'
WHERE dep.name = 'Lambayeque'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Barranca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Barranca'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paramonga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Barranca'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pativilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Barranca'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Supe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Barranca'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Supe Puerto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Barranca'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cajatambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajatambo'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Copa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajatambo'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Gorgor', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajatambo'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancapon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajatambo'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cajatambo'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Arahuay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huamantanga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lachaqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Buenaventura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa de Quives', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Canta'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Asia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calango', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cerro Azul', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coayllo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Imperial', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lunahuana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mala', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nuevo Imperial', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacaran', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quilmana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Luis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Vicente de Cañete', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz de Flores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Zuñiga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Cañete'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Atavillos Alto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Atavillos Bajo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aucallama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chancay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaral', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ihuari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lampian', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacaraos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de Acos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz de Andamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sumbilca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Veintisiete de Noviembre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaral'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Antioquia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Callahuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carampoma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chicla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuenca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachupampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huarochiri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lahuaytambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Langa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mariatana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Matucana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ricardo Palma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Andres de Tupicocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Bartolome', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Damian', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Iris', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Tantaranche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Lorenzo de Quinti', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Mateo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Mateo de Otao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Casta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Huancayre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Laraos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sangallaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz de Cocachacra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Eulalia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Anchucaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Tuna', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Domingo de los Olleros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Surco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huarochiri'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ambar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caleta de Carquin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Checras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Hualmay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huaura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Leoncio Prado', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paccho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Leonor', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Maria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vegueta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huaura'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ancon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Barranco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Breña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carabayllo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaclacayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chorrillos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cieneguilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Comas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Agustino', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Independencia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jesus Maria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Molina', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Victoria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lima', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lince', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Los Olivos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lurigancho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lurin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Magdalena del Mar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miraflores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachacamac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucusana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pueblo Libre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puente Piedra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Punta Hermosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Punta Negra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rimac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Bartolo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Borja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Isidro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Lurigancho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Miraflores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Luis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Martin de Porres', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Anita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Maria del Mar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Surco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Surquillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Villa Maria del Triunfo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Villa el Salvador', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lima'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andajes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oyon'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caujul', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oyon'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oyon'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Navan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oyon'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oyon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oyon'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachangara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oyon'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Allauca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayaviri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Azangaro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cacra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carania', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Catahuasi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chocos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cochas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colonia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Hongos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huampara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huangascar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huantan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huañec', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Laraos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lincha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Madean', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miraflores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Omas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Putinza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quinches', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quinocay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Joaquin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Pilas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tanta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tauripampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tupe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vitis', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Viñac', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yauyos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yauyos'
WHERE dep.name = 'Lima'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Balsapuerto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Alto Amazonas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jeberos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Alto Amazonas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lagunas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Alto Amazonas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Cruz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Alto Amazonas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Teniente Cesar Lopez Rojas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Alto Amazonas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yurimaguas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Alto Amazonas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Andoas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Datem del Marañon'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Barranca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Datem del Marañon'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cahuapanas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Datem del Marañon'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manseriche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Datem del Marañon'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Morona', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Datem del Marañon'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pastaza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Datem del Marañon'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nauta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Loreto'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Parinari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Loreto'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tigre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Loreto'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Trompeteros', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Loreto'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Urarinas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Loreto'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pebas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Ramon Castilla'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ramon Castilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Ramon Castilla'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pablo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Ramon Castilla'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yavari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Ramon Castilla'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Nanay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Belen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Fernando Lores', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Indiana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Iquitos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Las Amazonas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mazan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Napo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Punchana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan Bautista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Torres Causana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Maynas'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Putumayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Putumayo'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rosa Panduro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Putumayo'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Teniente Manuel Clavero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Putumayo'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yaguas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Putumayo'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Tapiche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Capelo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Emilio San Martin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jenaro Herrera', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Maquia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puinahua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Requena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saquena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Soplin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tapiche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yaquerana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Requena'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Contamana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ucayali'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Inahuaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ucayali'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Padre Marquez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ucayali'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampa Hermosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ucayali'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sarayacu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ucayali'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vargas Guerra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ucayali'
WHERE dep.name = 'Loreto'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Fitzcarrald', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Manu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huepetuhe', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Manu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Madre de Dios', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Manu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Manu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Iberia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tahuamanu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Iñapari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tahuamanu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tahuamanu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tahuamanu'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Inambari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tambopata'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Laberinto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tambopata'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Las Piedras', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tambopata'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambopata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tambopata'
WHERE dep.name = 'Madre de Dios'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chojata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coalaque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ichuña', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Capilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lloque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Matalaque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Omate', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puquina', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quinistaquillas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ubinas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yunga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'General Sanchez Cerro'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Algarrobal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ilo'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ilo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ilo'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ilo'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Carumas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuchumbaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Moquegua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Samegua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Cristobal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Torata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Nieto'
WHERE dep.name = 'Moquegua'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chacayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Goyllarisquizga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Pillao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Ana de Tusi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tapuc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilcabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanahuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Daniel Alcides Carrion'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chontabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Constitucion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Oxapampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palcazu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pozuzo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puerto Bermudez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Villa Rica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Oxapampa'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chaupimarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huachon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huariaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayllay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ninacaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pallanchacra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucartambo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Francisco de Asis de Yarusyacan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Simon Bolivar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ticlacayan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tinyahuarco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vicco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanacancha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Pasco'
WHERE dep.name = 'Pasco'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayabaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Frias', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jilili', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lagunas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Montero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pacaipampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paimas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sapillica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sicchez', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Suyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Ayabaca'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canchaque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Carmen de la Frontera', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancabamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huarmaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lalaquiz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel de el Faique', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sondor', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sondorillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancabamba'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Buenos Aires', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chalaco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chulucanas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Matanza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Morropon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salitral', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Bigote', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Catalina de Mossa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santo Domingo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yamango', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Morropon'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Amotape', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Arenal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Colan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Huaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tamarindo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vichayal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Paita'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Castilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Catacaos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cura Mori', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Tallan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Arena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Union', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Las Lomas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Piura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tambo Grande', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Veintiseis de Octubre', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Piura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bellavista de la Union', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sechura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bernal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sechura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cristo Nos Valga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sechura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rinconada Llicuar', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sechura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sechura', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sechura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vice', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sechura'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bellavista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ignacio Escudero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lancones', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Marcavelica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Miguel Checa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Querecotillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Salitral', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sullana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sullana'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Alto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Talara'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Brea', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Talara'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lobitos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Talara'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Los Organos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Talara'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mancora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Talara'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pariñas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Talara'
WHERE dep.name = 'Piura'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Achaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Arapa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Asillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Azangaro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caminaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chupa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jose Domingo Choquehuanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Muñani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Potoni', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saman', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Anton', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de Salinas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santiago de Pupuja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tirapata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Azangaro'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ajoyani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayapata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coasa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Corani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Crucero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ituata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Macusani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ollachea', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Gaban', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Usicayos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Carabaya'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Desaguadero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huacullani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Juli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Kelluyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pisacoma', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pomata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Zepita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Chucuito'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Capazo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Collao'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conduriri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Collao'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ilave', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Collao'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pilcuyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Collao'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Collao'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cojata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huancane', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huatasani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Inchupalla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pusi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rosaspata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Taraco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilque Chico', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huancane'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cabanilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calapuja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nicasio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ocuviri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paratia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Lucia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilavila', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lampa'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Antauta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ayaviri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cupi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Llalli', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Macari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nuñoa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Orurillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Umachiri', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Melgar'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Conima', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moho'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huayrapata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moho'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Moho', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moho'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tilali', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moho'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Acora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Amantani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Atuncolla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Capachica', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chucuito', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Mañazo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Paucarcolla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pichacani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Plateria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Puno', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tiquillaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Vilque', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Puno'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ananea', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Antonio de Putina'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pedro Vilca Apaza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Antonio de Putina'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Putina', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Antonio de Putina'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quilcapuncu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Antonio de Putina'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sina', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Antonio de Putina'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cabana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Roman'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cabanillas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Roman'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caracoto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Roman'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Juliaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Roman'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Miguel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Roman'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Inambari', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuyocuyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Limbani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Patambuco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Phara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quiaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan del Oro', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pedro de Putina Punco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sandia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yanahuaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Sandia'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Anapia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Copani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuturapi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ollaraya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tinicachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Unicachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yunguyo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Yunguyo'
WHERE dep.name = 'Puno'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Biavo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bellavista'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bajo Biavo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bellavista'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Bellavista', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bellavista'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huallaga', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bellavista'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Pablo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bellavista'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Rafael', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Bellavista'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Agua Blanca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Dorado'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jose de Sisa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Dorado'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Martin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Dorado'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Rosa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Dorado'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shatoja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'El Dorado'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto Saposoa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huallaga'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Eslabon', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huallaga'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Piscoyacu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huallaga'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sacanche', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huallaga'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Saposoa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huallaga'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tingo de Saposoa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Huallaga'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alonso de Alvarado', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Barranquita', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caynarachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cuñumbuqui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Lamas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pinto Recodo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rumisapa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Roque de Cumbaza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shanao', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tabalosos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Zapatero', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Lamas'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Campanilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Caceres'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huicungo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Caceres'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Juanjui', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Caceres'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachiza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Caceres'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pajarillo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Mariscal Caceres'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calzada', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moyobamba'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Habana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moyobamba'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Jepelacio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moyobamba'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Moyobamba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moyobamba'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Soritor', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moyobamba'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yantalo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Moyobamba'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Buenos Aires', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Caspisapa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Picota', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pilluana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pucacaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Cristobal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Hilarion', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shamboyacu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tingo de Ponasa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tres Unidos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Picota'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Awajun', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Elias Soplin Vargas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nueva Cajamarca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pardo Miguel', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Posic', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Rioja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Fernando', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yorongos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yuracyacu', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Rioja'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alberto Leveau', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cacatachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chazuta', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Chipurana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'El Porvenir', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huimbayoc', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Juan Guerra', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Banda de Shilcayo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Morales', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Papaplaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Antonio', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sauce', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shapaja', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tarapoto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'San Martin'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nuevo Progreso', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tocache'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Polvora', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tocache'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Santa Lucia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tocache'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Shunte', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tocache'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tocache', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tocache'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Uchiza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tocache'
WHERE dep.name = 'San Martin'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Cairani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Candarave'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Camilaca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Candarave'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Candarave', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Candarave'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curibaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Candarave'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huanuara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Candarave'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Quilahuani', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Candarave'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ilabaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jorge Basadre'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ite', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jorge Basadre'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Locumba', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Jorge Basadre'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alto de la Alianza', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ciudad Nueva', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Coronel Gregorio Albarracin Lanchipa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Inclan', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Yarada los Palos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pachia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Palca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pocollay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sama', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tacna', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tacna'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Estique', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Estique-pampa', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Heroes Albarracin', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sitajara', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Susapaya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tarata', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tarucachi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Ticaco', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tarata'
WHERE dep.name = 'Tacna'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Canoas de Punta Sal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contralmirante Villar'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Casitas', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contralmirante Villar'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Zorritos', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Contralmirante Villar'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Corrales', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tumbes'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'La Cruz', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tumbes'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Pampas de Hospital', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tumbes'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Jacinto', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tumbes'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'San Juan de la Virgen', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tumbes'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tumbes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Tumbes'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Aguas Verdes', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Zarumilla'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Matapalo', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Zarumilla'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Papayal', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Zarumilla'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Zarumilla', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Zarumilla'
WHERE dep.name = 'Tumbes'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Raimondi', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Atalaya'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Sepahua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Atalaya'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Tahuania', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Atalaya'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yurua', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Atalaya'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Calleria', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Campoverde', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Iparia', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Manantay', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Masisea', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Nueva Requena', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Yarinacocha', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Coronel Portillo'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Alexander Von Humboldt', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Boqueron', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Curimana', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Huipoca', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Irazola', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Neshuya', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Padre Abad', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Padre Abad'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;

INSERT INTO catalog_district (id, name, active, department_id, province_id)
SELECT gen_random_uuid(), 'Purus', TRUE, dep.id, prov.id
FROM catalog_department dep
JOIN catalog_province prov ON prov.department_id = dep.id
 AND prov.name = 'Purus'
WHERE dep.name = 'Ucayali'
ON CONFLICT (province_id, name) DO NOTHING;
