-- =====================================================================
-- CineMax - Script 07: Ampliación del modelo (estilo cartelera Procinal)
-- Se ejecuta sobre las tablas ya creadas (02, 03 y 04). No borra datos.
-- Se puede ejecutar más de una vez sin errores.
-- Ejecutar conectado a la base "cinemax" (public@cinemax).
-- =====================================================================

-- ---------------------------------------------------------------------
-- PELICULAS: datos de la ficha de la película
-- ---------------------------------------------------------------------
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS titulo_original VARCHAR(150);
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS sinopsis        TEXT;
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS reparto         VARCHAR(300);
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS imagen_url      VARCHAR(300);
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS trailer_url     VARCHAR(300);
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS fecha_estreno   DATE;
ALTER TABLE peliculas ADD COLUMN IF NOT EXISTS estado          VARCHAR(20) NOT NULL DEFAULT 'EN_CARTELERA';

ALTER TABLE peliculas DROP CONSTRAINT IF EXISTS ck_peliculas_estado;
ALTER TABLE peliculas ADD CONSTRAINT ck_peliculas_estado
    CHECK (estado IN ('EN_CARTELERA', 'PREVENTA', 'PROXIMAMENTE'));

COMMENT ON COLUMN peliculas.estado IS 'EN_CARTELERA, PREVENTA o PROXIMAMENTE';

-- ---------------------------------------------------------------------
-- FUNCIONES: formato, idioma y precio por ubicación
-- La columna "precio" existente pasa a ser el precio de la ubicación GENERAL.
-- ---------------------------------------------------------------------
ALTER TABLE funciones ADD COLUMN IF NOT EXISTS formato VARCHAR(10) NOT NULL DEFAULT '2D';
ALTER TABLE funciones ADD COLUMN IF NOT EXISTS idioma  VARCHAR(15) NOT NULL DEFAULT 'DOBLADA';
ALTER TABLE funciones ADD COLUMN IF NOT EXISTS precio_general_plus NUMERIC(10,2);

-- Funciones que ya existían: General+ = General + 2.000 (diferencia vista en Procinal)
UPDATE funciones SET precio_general_plus = precio + 2000 WHERE precio_general_plus IS NULL;
ALTER TABLE funciones ALTER COLUMN precio_general_plus SET NOT NULL;

ALTER TABLE funciones DROP CONSTRAINT IF EXISTS ck_funciones_formato;
ALTER TABLE funciones ADD CONSTRAINT ck_funciones_formato
    CHECK (formato IN ('2D', '3D', 'IMAX'));

ALTER TABLE funciones DROP CONSTRAINT IF EXISTS ck_funciones_idioma;
ALTER TABLE funciones ADD CONSTRAINT ck_funciones_idioma
    CHECK (idioma IN ('DOBLADA', 'SUBTITULADA'));

ALTER TABLE funciones DROP CONSTRAINT IF EXISTS ck_funciones_precio_plus;
ALTER TABLE funciones ADD CONSTRAINT ck_funciones_precio_plus
    CHECK (precio_general_plus >= precio);

COMMENT ON COLUMN funciones.precio              IS 'Precio de la ubicación GENERAL';
COMMENT ON COLUMN funciones.precio_general_plus IS 'Precio de la ubicación GENERAL+';

-- ---------------------------------------------------------------------
-- COMPRAS: ubicación elegida, precio aplicado y cargo por servicio
-- valor_total = (precio_unitario x cantidad_boletos) + cargo_servicio
-- ---------------------------------------------------------------------
ALTER TABLE compras ADD COLUMN IF NOT EXISTS ubicacion      VARCHAR(15)   NOT NULL DEFAULT 'GENERAL';
ALTER TABLE compras ADD COLUMN IF NOT EXISTS precio_unitario NUMERIC(10,2);
ALTER TABLE compras ADD COLUMN IF NOT EXISTS cargo_servicio  NUMERIC(10,2) NOT NULL DEFAULT 0;

-- Compras que ya existían: se deduce el precio unitario del total guardado
UPDATE compras
   SET precio_unitario = ROUND(valor_total / cantidad_boletos, 2)
 WHERE precio_unitario IS NULL;
ALTER TABLE compras ALTER COLUMN precio_unitario SET NOT NULL;

ALTER TABLE compras DROP CONSTRAINT IF EXISTS ck_compras_ubicacion;
ALTER TABLE compras ADD CONSTRAINT ck_compras_ubicacion
    CHECK (ubicacion IN ('GENERAL', 'GENERAL_PLUS'));

ALTER TABLE compras DROP CONSTRAINT IF EXISTS ck_compras_precio_unitario;
ALTER TABLE compras ADD CONSTRAINT ck_compras_precio_unitario
    CHECK (precio_unitario >= 0);

ALTER TABLE compras DROP CONSTRAINT IF EXISTS ck_compras_cargo;
ALTER TABLE compras ADD CONSTRAINT ck_compras_cargo
    CHECK (cargo_servicio >= 0);

-- El total debe cuadrar para las compras nuevas (NOT VALID: no revisa las antiguas)
ALTER TABLE compras DROP CONSTRAINT IF EXISTS ck_compras_total;
ALTER TABLE compras ADD CONSTRAINT ck_compras_total
    CHECK (valor_total = precio_unitario * cantidad_boletos + cargo_servicio) NOT VALID;

-- ---------------------------------------------------------------------
-- Vista para el reporte / historial del cajero
-- ---------------------------------------------------------------------
CREATE OR REPLACE VIEW v_historial_compras AS
SELECT c.id,
       c.fecha_compra,
       c.nombre_cliente,
       p.titulo,
       f.fecha   AS fecha_funcion,
       f.hora    AS hora_funcion,
       f.sala,
       f.formato,
       f.idioma,
       c.ubicacion,
       c.cantidad_boletos,
       c.precio_unitario,
       c.cargo_servicio,
       c.valor_total
FROM compras c
JOIN funciones f ON f.id = c.funcion_id
JOIN peliculas p ON p.id = f.pelicula_id;
