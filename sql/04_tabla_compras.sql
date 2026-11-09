-- =====================================================================
-- CineMax - Script 04: Tabla COMPRAS (boletas)
-- Solo se listan y se crean (no hay devoluciones ni eliminación).
-- valor_total = precio de la función x cantidad_boletos (lo calcula el backend).
-- =====================================================================

CREATE TABLE IF NOT EXISTS compras (
    id               BIGSERIAL      PRIMARY KEY,
    funcion_id       BIGINT         NOT NULL,
    nombre_cliente   VARCHAR(120)   NOT NULL,
    cantidad_boletos INTEGER        NOT NULL,
    valor_total      NUMERIC(12,2)  NOT NULL,
    fecha_compra     TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_compras_funcion
        FOREIGN KEY (funcion_id) REFERENCES funciones (id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_compras_cantidad CHECK (cantidad_boletos > 0),
    CONSTRAINT ck_compras_valor    CHECK (valor_total >= 0)
);

-- Índices para el historial / reporte por día o rango de fechas
CREATE INDEX IF NOT EXISTS idx_compras_funcion ON compras (funcion_id);
CREATE INDEX IF NOT EXISTS idx_compras_fecha   ON compras (fecha_compra);

COMMENT ON TABLE compras IS 'Historial de venta de boletas (sin devoluciones)';
