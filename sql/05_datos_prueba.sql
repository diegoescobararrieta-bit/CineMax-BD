INSERT INTO peliculas (titulo, genero, duracion_min, clasificacion) VALUES
 ('Misión Imposible: Sentencia Final', 'Acción',     169, '+12'),
 ('Intensamente 2',                    'Animación',  96,  'Todo público'),
 ('Oppenheimer',                       'Drama',      180, '+15'),
 ('El Conjuro 4',                      'Terror',     135, '+15'),
 ('Coco',                              'Animación',  105, 'Todo público');

INSERT INTO funciones (pelicula_id, fecha, hora, sala, precio, cupos_disponibles) VALUES
 (1, CURRENT_DATE + 1, '18:00', 'Sala 1', 16000.00, 48),   -- 50 - 2 vendidas
 (1, CURRENT_DATE + 1, '21:00', 'Sala 1', 18000.00, 50),
 (2, CURRENT_DATE + 2, '15:00', 'Sala 2', 14000.00, 36),   -- 40 - 4 vendidas
 (3, CURRENT_DATE + 2, '19:30', 'Sala 3', 18000.00, 30),
 (4, CURRENT_DATE + 3, '20:00', 'Sala 2', 16000.00, 37),   -- 40 - 3 vendidas
 (5, CURRENT_DATE + 3, '14:00', 'Sala 3', 14000.00, 30);


INSERT INTO compras (funcion_id, nombre_cliente, cantidad_boletos, valor_total, fecha_compra) VALUES
 (1, 'Carlos Pérez',   2, 32000.00, CURRENT_TIMESTAMP - INTERVAL '2 days'),
 (3, 'María Gómez',    4, 56000.00, CURRENT_TIMESTAMP - INTERVAL '1 day'),
 (5, 'Andrés Rojas',   3, 48000.00, CURRENT_TIMESTAMP);
