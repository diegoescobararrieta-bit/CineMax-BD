CREATE TABLE IF NOT EXISTS peliculas (
    id            BIGSERIAL     PRIMARY KEY,
    titulo        VARCHAR(150)  NOT NULL,
    genero        VARCHAR(60)   NOT NULL,
    duracion_min  INTEGER       NOT NULL,
    clasificacion VARCHAR(20)   NOT NULL,
    CONSTRAINT ck_peliculas_duracion CHECK (duracion_min > 0)
);

COMMENT ON TABLE  peliculas               IS 'Cartelera: películas disponibles en el cine';
COMMENT ON COLUMN peliculas.duracion_min  IS 'Duración en minutos';
COMMENT ON COLUMN peliculas.clasificacion IS 'Ej: Todo público, +7, +12, +15, +18';
