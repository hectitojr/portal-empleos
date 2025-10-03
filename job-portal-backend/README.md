# job-portal-backend

Monolito modular (Hexagonal + DDD + TDD) – Spring Boot 3.5.6, Java 21.

## Requisitos
- Java 21
- Maven 3.9+
- PostgreSQL 16 (DB local: `job_portal_dev`, user/password: `job_portal`)

## Perfiles y configuración
Ver `modules/api/src/main/resources/application.yaml` (perfiles: `dev`, `test`, `prod`).

## Migraciones
Flyway ejecuta migraciones desde `modules/api/src/main/resources/db/migration`.

## Compilar
```bash
mvn -DskipTests clean package
