-- =====================================================
-- CineMax - Script 09: afiches y trailers de las peliculas
-- Base de datos: cinemax (PostgreSQL)
-- Ejecutar despues de los scripts 01 a 08.
--
-- imagen_url: ruta del afiche dentro del frontend (carpeta public/img)
-- trailer_url: enlace de YouTube en formato embed
-- =====================================================

-- Afiches
UPDATE peliculas SET imagen_url = '/img/como-robar-un-banco.jpg' WHERE titulo = 'Cómo robar un banco';
UPDATE peliculas SET imagen_url = '/img/ebenezer.jpg'            WHERE titulo = 'Ebenezer';
UPDATE peliculas SET imagen_url = '/img/gato-sombrero.jpg'       WHERE titulo = 'El gato con sombrero';
UPDATE peliculas SET imagen_url = '/img/avengers.jpg'            WHERE titulo = 'Avengers: Doomsday';
UPDATE peliculas SET imagen_url = '/img/dune3.jpg'               WHERE titulo = 'Duna Parte Tres';

-- Trailers
UPDATE peliculas SET trailer_url = 'https://www.youtube.com/embed/rMfNFFDAJoU' WHERE titulo = 'Cómo robar un banco';
UPDATE peliculas SET trailer_url = 'https://www.youtube.com/embed/A7lyvgnDuDE' WHERE titulo = 'Ebenezer';
UPDATE peliculas SET trailer_url = 'https://www.youtube.com/embed/Bi3d1w_Urdk' WHERE titulo = 'El gato con sombrero';
UPDATE peliculas SET trailer_url = 'https://www.youtube.com/embed/lAr_uspgHm8' WHERE titulo = 'Avengers: Doomsday';
UPDATE peliculas SET trailer_url = 'https://www.youtube.com/embed/HwgSQcszj6Y' WHERE titulo = 'Duna Parte Tres';

-- Verificacion
SELECT id, titulo, imagen_url, trailer_url FROM peliculas ORDER BY id;
