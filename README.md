# CineMax - Base de Datos

Repositorio 1 de 3 del proyecto **Sistema de Taquilla de Cine** (Programación Basada en Componentes).
Contiene los scripts SQL (DDL) del esquema relacional en **PostgreSQL**.

Repositorios del proyecto:
1. **CineMax-BD** (este): scripts SQL.
2. CineMax-Backend: API REST con Spring Boot (Controller - Service - Repository).
3. CineMax-Frontend: interfaz en Angular.

## Integrantes
- Diego Escobar Arrieta
- Nestor Andres Torres Mora

## Modelo de datos

```
peliculas (1) ──< funciones (1) ──< compras
```

| Tabla | Campos | Operaciones |
|---|---|---|
| `peliculas` | id, titulo, genero, duracion_min, clasificacion | CRUD completo |
| `funciones` | id, pelicula_id (FK), fecha, hora, sala, precio, cupos_disponibles | CRUD completo |
| `compras` | id, funcion_id (FK), nombre_cliente, cantidad_boletos, valor_total, fecha_compra | Solo listar y crear |

Reglas en la base de datos: claves primarias autoincrementales, claves foráneas con `ON DELETE RESTRICT`,
y restricciones `CHECK` (duración > 0, precio >= 0, cupos >= 0, cantidad de boletos > 0).
Las reglas de negocio (cupos insuficientes -> 409 y cálculo del total) las aplica el backend.

## Cómo ejecutarlo (DBeaver)
1. Conéctese a PostgreSQL (base `postgres`) y ejecute `sql/01_crear_base_datos.sql`.
2. Conéctese a la base `cinemax`.
3. Ejecute en orden (Alt+X): `02`, `03`, `04` y, opcionalmente, `05` (datos de prueba).
4. Use `06_consultas_verificacion.sql` para comprobar.

## Estructura
```
sql/
  01_crear_base_datos.sql
  02_tabla_peliculas.sql
  03_tabla_funciones.sql
  04_tabla_compras.sql
  05_datos_prueba.sql
  06_consultas_verificacion.sql
```
