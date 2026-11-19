# CineMax - Base de Datos

Repositorio 1 de 3 del proyecto **Sistema de Taquilla de Cine** (Programación Basada en Componentes).
Contiene los scripts SQL (DDL) del esquema relacional en **PostgreSQL**.

Repositorios del proyecto:
1. **CineMax-BD** (este): scripts SQL.
2. [CineMax-Backend](https://github.com/diegoescobararrieta-bit/CineMax-Backend): API REST con Spring Boot (Controller - Service - Repository).
3. [CineMax-Frontend](https://github.com/diegoescobararrieta-bit/CineMax-Frontend): interfaz en Angular.

## Integrantes
- Diego Escobar Arrieta
- Nestor Andres Torres Mora

## Modelo de datos

```
peliculas (1) ──< funciones (1) ──< compras
```

| Tabla | Campos | Operaciones |
|---|---|---|
| `peliculas` | id, titulo, titulo_original, genero, duracion_min, clasificacion, sinopsis, reparto, imagen_url, trailer_url, fecha_estreno, estado | CRUD completo |
| `funciones` | id, pelicula_id (FK), fecha, hora, sala, formato, idioma, precio, precio_general_plus, cupos_disponibles | CRUD completo |
| `compras` | id, funcion_id (FK), nombre_cliente, cantidad_boletos, ubicacion, precio_unitario, cargo_servicio, valor_total, fecha_compra | Solo listar y crear |

Valores por defecto: `peliculas.estado` = `EN_CARTELERA`, `funciones.formato` = `2D`, `funciones.idioma` = `DOBLADA`,
`compras.ubicacion` = `GENERAL` (también puede ser `GENERAL_PLUS`).

Reglas en la base de datos: claves primarias autoincrementales, claves foráneas con `ON DELETE RESTRICT`,
y restricciones `CHECK` (duración > 0, precio >= 0, cupos >= 0, cantidad de boletos > 0).
Las reglas de negocio (cupos insuficientes -> 409 y cálculo del total: precio de la ubicación x cantidad + cargo por
servicio de $1.500) las aplica el backend.

## Cómo ejecutarlo (DBeaver)
1. Conéctese a PostgreSQL (base `postgres`) y ejecute `sql/01_crear_base_datos.sql`.
2. Conéctese a la base `cinemax`.
3. Ejecute en orden (Alt+X): `02` a `07` y, opcionalmente, `08` (datos de prueba).
4. Use `09_consultas_verificacion.sql` para comprobar.

## Estructura
```
sql/
  01_crear_base_datos.sql
  02_tabla_peliculas.sql
  03_tabla_funciones.sql
  04_tabla_compras.sql
  05_...
  06_...
  07_...
  08_datos_prueba.sql
  09_consultas_verificacion.sql
```

## Conexión con el backend
El backend (Spring Boot) usa Hibernate en modo `validate`: solo comprueba que las entidades coincidan con estas
tablas y no modifica la base. Si cambia una tabla aquí, debe actualizarse la entidad correspondiente.