# Talleres SQL

Repositorio con soluciones y diagramas de talleres prácticos de SQL: diseño de bases de datos, normalización, restricciones y consultas (DDL, DML, DQL).

## Contenido

- `taller1.sql`, `taller2.sql` — Ejercicios progresivos de SQL (creación de tablas, inserción de datos, consultas, filtros, ordenamiento).
- `electrohogar_retos.sql` — Retos de modelado y consultas SQL sobre el caso de una tienda (productos, clientes, ventas).
- `Taller4_404.md` — Taller de claves, restricciones y modelo Entidad-Relación en MySQL (tienda de ropa: productos, categorías, clientes, ventas).
- `MER_Hospital_3FN.png` — Diagrama Entidad-Relación en Tercera Forma Normal (3FN) del caso de estudio de ingresos hospitalarios.

## Temas cubiertos

- Diseño de entidades, atributos, llaves primarias y foráneas.
- Normalización (1FN, 2FN, 3FN) y resolución de dependencias transitivas.
- Modelado de relaciones 1:N y N:M, incluyendo tablas intermedias.
- DDL: `CREATE TABLE`, `ALTER TABLE`, restricciones (`NOT NULL`, `CHECK`, `UNIQUE`, `DEFAULT`).
- DML: `INSERT`, `UPDATE`, `DELETE` con verificación previa del alcance del filtro.
- DQL: filtros, operadores de rango y texto, ordenamiento, agregación y agrupación.

## Requisitos

- MySQL 8.0 o superior (o PostgreSQL, según el ejercicio).
- Cliente SQL de preferencia (MySQL Workbench, DBeaver, línea de comandos, etc.).

## Uso

1. Clonar el repositorio.
2. Ejecutar los scripts `.sql` en orden dentro del motor de base de datos.
3. Revisar los archivos `.md` para el contexto y las consignas de cada taller.
