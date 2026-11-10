CREATE TABLE IF NOT EXISTS funciones (
    id                BIGSERIAL      PRIMARY KEY,
    pelicula_id       BIGINT         NOT NULL,
    fecha             DATE           NOT NULL,
    hora              TIME           NOT NULL,
    sala              VARCHAR(30)    NOT NULL,
    precio            NUMERIC(10,2)  NOT NULL,
    cupos_disponibles INTEGER        NOT NULL,
    CONSTRAINT fk_funciones_pelicula
        FOREIGN KEY (pelicula_id) REFERENCES peliculas (id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_funciones_precio CHECK (precio >= 0),
    CONSTRAINT ck_funciones_cupos  CHECK (cupos_disponibles >= 0)
);

CREATE INDEX IF NOT EXISTS idx_funciones_pelicula ON funciones (pelicula_id);

COMMENT ON TABLE  funciones                   IS 'Funciones (horarios) de cada película';
COMMENT ON COLUMN funciones.cupos_disponibles IS 'Boletas que aún se pueden vender; se descuenta en cada compra';
