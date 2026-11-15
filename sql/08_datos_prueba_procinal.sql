-- =====================================================================
-- CineMax - Script 08: Datos de prueba estilo Procinal (OPCIONAL)
-- ATENCIÓN: BORRA todos los datos de peliculas, funciones y compras y
-- reinicia los ids. Ejecutar solo después del script 07.
-- Los datos son de ejemplo: duraciones, clasificaciones y precios de
-- algunas funciones deben ajustarse a los reales.
-- Un solo teatro: Viva Barrancabermeja (las salas se manejan en funciones.sala).
-- =====================================================================

TRUNCATE TABLE compras, funciones, peliculas RESTART IDENTITY CASCADE;

INSERT INTO peliculas
  (titulo, titulo_original, genero, duracion_min, clasificacion, reparto, fecha_estreno, estado) VALUES
 ('Cómo robar un banco',      'How to Rob a Bank',   'Acción',          110, '+15', 'Nicholas Hoult, Zoë Kravitz, Anna Sawai, Rhenzy Feliz, Pete Davidson, John C. Reilly', CURRENT_DATE - 10, 'EN_CARTELERA'),
 ('Ebenezer',                 'Ebenezer',            'Terror',          105, '+15', 'Johnny Depp',                                                                          CURRENT_DATE - 3,  'EN_CARTELERA'),
 ('El gato con sombrero',     'The Cat in the Hat',  'Animación',       90,  'Todo público', NULL,                                                                          CURRENT_DATE - 10, 'EN_CARTELERA'),
 ('Avengers: Doomsday',       'Avengers: Doomsday',  'Acción',          166, '+12', 'Robert Downey Jr., Pedro Pascal, Chris Hemsworth',                                    DATE '2026-12-17', 'PREVENTA'),
 ('Duna Parte Tres',          'Dune: Part Three',    'Ciencia ficción', 150, '+12', NULL,                                                                                   DATE '2026-12-17', 'PREVENTA');

-- Los cupos ya tienen descontadas las compras de ejemplo (salas de 60 sillas)
INSERT INTO funciones
  (pelicula_id, fecha, hora, sala, formato, idioma, precio, precio_general_plus, cupos_disponibles) VALUES
 (1, CURRENT_DATE + 1, '18:40', 'Sala 1', '2D',   'DOBLADA',     11000.00, 13000.00, 58),
 (1, CURRENT_DATE + 1, '21:15', 'Sala 1', '2D',   'DOBLADA',     11000.00, 13000.00, 60),
 (2, CURRENT_DATE + 1, '18:20', 'Sala 2', '2D',   'DOBLADA',     11000.00, 13000.00, 59),
 (3, CURRENT_DATE + 1, '19:15', 'Sala 3', '2D',   'DOBLADA',     11000.00, 13000.00, 57),
 (3, CURRENT_DATE + 2, '15:00', 'Sala 3', '3D',   'DOBLADA',     14000.00, 16000.00, 60),
 (4, DATE '2026-12-17', '21:15', 'Sala 1', '2D',  'DOBLADA',     11000.00, 13000.00, 60),
 (5, DATE '2026-12-17', '20:00', 'Sala 2', 'IMAX','SUBTITULADA', 16000.00, 19000.00, 60);

-- valor_total = precio_unitario x cantidad + cargo_servicio (1.500)
INSERT INTO compras
  (funcion_id, nombre_cliente, cantidad_boletos, ubicacion, precio_unitario, cargo_servicio, valor_total, fecha_compra) VALUES
 (1, 'Carlos Pérez', 2, 'GENERAL',      11000.00, 1500.00, 23500.00, CURRENT_TIMESTAMP - INTERVAL '2 days'),
 (4, 'María Gómez',  3, 'GENERAL_PLUS', 13000.00, 1500.00, 40500.00, CURRENT_TIMESTAMP - INTERVAL '1 day'),
 (3, 'Andrés Rojas', 1, 'GENERAL',      11000.00, 1500.00, 12500.00, CURRENT_TIMESTAMP);
