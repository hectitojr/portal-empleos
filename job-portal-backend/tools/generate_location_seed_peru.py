import csv
import re
from pathlib import Path

# ======================================================
# CONFIGURACIÓN EXACTA DEL ARCHIVO DE ORIGEN
# ======================================================

CSV_PATH = Path(r"C:\Users\Ronald\Desktop\ubigeos\UBIGEOS_2022_1891_distritos.csv")
OUT_PATH = Path("R__location_seed_peru.sql")

DELIMITER = ";"  # CSV separado por punto y coma
ENCODING = "latin1"  # Encoding real del archivo (Ñ, acentos, etc.)

COL_DEPT = "NOMBRE_DEPARTAMENTO"
COL_PROV = "NOMBRE_PROVINCIA"
COL_DIST = "NOMBRE_DISTRITO"


# ======================================================
# HELPERS DE NORMALIZACIÓN
# ======================================================

def normalize(text: str) -> str:
    """
    Limpia espacios y normaliza espacios múltiples.
    """
    if text is None:
        return ""
    text = text.strip()
    text = re.sub(r"\s+", " ", text)
    return text


def title_case_es(text: str) -> str:
    """
    Convierte nombres propios a Title Case en español.

    Ejemplos:
    - 'SAN MARTIN'        -> 'San Martin'
    - 'LA LIBERTAD'       -> 'La Libertad'
    - 'MADRE DE DIOS'     -> 'Madre de Dios'
    - 'RODRIGUEZ DE MENDOZA' -> 'Rodriguez de Mendoza'

    No inventa tildes.
    """
    lower_words = {"de", "del", "la", "las", "el", "los", "y"}

    words = text.lower().split(" ")
    result = []

    for i, word in enumerate(words):
        if i > 0 and word in lower_words:
            result.append(word)
        else:
            result.append(word.capitalize())

    return " ".join(result)


def sql_escape(text: str) -> str:
    """
    Escapa comillas simples para SQL.
    """
    return text.replace("'", "''")


# ======================================================
# MAIN
# ======================================================

def main():
    rows = []

    # Lectura robusta del CSV real
    with CSV_PATH.open("r", encoding=ENCODING, newline="") as f:
        reader = csv.DictReader(f, delimiter=DELIMITER)

        if reader.fieldnames is None:
            raise SystemExit("ERROR: No se detectó cabecera en el archivo CSV.")

        # Limpieza defensiva de cabeceras
        reader.fieldnames = [
            fn.strip().replace("\ufeff", "") for fn in reader.fieldnames
        ]

        required = {COL_DEPT, COL_PROV, COL_DIST}
        if not required.issubset(set(reader.fieldnames)):
            raise SystemExit(
                f"ERROR: Columnas incorrectas.\n"
                f"Detectadas: {reader.fieldnames}\n"
                f"Requeridas: {sorted(required)}"
            )

        for r in reader:
            dept = title_case_es(normalize(r.get(COL_DEPT, "")))
            prov = title_case_es(normalize(r.get(COL_PROV, "")))
            dist = title_case_es(normalize(r.get(COL_DIST, "")))

            if not (dept and prov and dist):
                continue

            rows.append((dept, prov, dist))

    # ======================================================
    # DEDUPLICACIÓN Y ORDEN (DETERMINISTA)
    # ======================================================

    departments = sorted({d for d, _, _ in rows})
    provinces = sorted({(d, p) for d, p, _ in rows}, key=lambda x: (x[0], x[1]))
    districts = sorted({(d, p, di) for d, p, di in rows}, key=lambda x: (x[0], x[1], x[2]))

    # ======================================================
    # GENERACIÓN DEL SQL
    # ======================================================

    lines = []
    lines.append("-- File: R__location_seed_peru.sql")
    lines.append("-- Title: Seed full Peru location hierarchy")
    lines.append("-- Purpose: Cargar catálogo completo oficial de Perú")
    lines.append("--          (Departamentos → Provincias → Distritos).")
    lines.append("-- Author: ZOEDATA_LAB | Generated automatically")
    lines.append("-- Source: UBIGEOS_2022_1891_distritos.csv")
    lines.append("-- Notes:")
    lines.append("--   - Idempotente (ON CONFLICT).")
    lines.append("--   - Determinista (ordenado).")
    lines.append("--   - Normalización a Title Case en español.")
    lines.append("")

    # -------------------------
    # 1) DEPARTAMENTOS
    # -------------------------
    lines.append("-------------------------")
    lines.append("-- 1) DEPARTAMENTOS")
    lines.append("-------------------------")

    for d in departments:
        lines.append(
            "INSERT INTO catalog_department (id, name, active)\n"
            f"VALUES (gen_random_uuid(), '{sql_escape(d)}', TRUE)\n"
            "ON CONFLICT (name) DO NOTHING;\n"
        )

    # -------------------------
    # 2) PROVINCIAS
    # -------------------------
    lines.append("-------------------------")
    lines.append("-- 2) PROVINCIAS")
    lines.append("-------------------------")

    for d, p in provinces:
        lines.append(
            "INSERT INTO catalog_province (id, department_id, name, active)\n"
            "SELECT gen_random_uuid(), dep.id, "
            f"'{sql_escape(p)}', TRUE\n"
            "FROM catalog_department dep\n"
            f"WHERE dep.name = '{sql_escape(d)}'\n"
            "ON CONFLICT (department_id, name) DO NOTHING;\n"
        )

    # -------------------------
    # 3) DISTRITOS
    # -------------------------
    lines.append("-------------------------")
    lines.append("-- 3) DISTRITOS")
    lines.append("-------------------------")

    for d, p, di in districts:
        lines.append(
            "INSERT INTO catalog_district (id, name, active, department_id, province_id)\n"
            "SELECT gen_random_uuid(), "
            f"'{sql_escape(di)}', TRUE, dep.id, prov.id\n"
            "FROM catalog_department dep\n"
            "JOIN catalog_province prov ON prov.department_id = dep.id\n"
            f" AND prov.name = '{sql_escape(p)}'\n"
            f"WHERE dep.name = '{sql_escape(d)}'\n"
            "ON CONFLICT (province_id, name) DO NOTHING;\n"
        )

    OUT_PATH.write_text("\n".join(lines), encoding="utf-8")

    print("GENERACIÓN COMPLETADA")
    print(f"Departamentos: {len(departments)} (esperado: 25)")
    print(f"Provincias: {len(provinces)} (esperado: 196)")
    print(f"Distritos: {len(districts)} (esperado: 1891)")
    print(f"Archivo generado: {OUT_PATH.resolve()}")


if __name__ == "__main__":
    main()
