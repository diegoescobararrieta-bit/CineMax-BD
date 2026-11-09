-- =====================================================================
-- CineMax - Script 06: Consultas de verificación
-- =====================================================================

-- 1) Cartelera con funciones (lo que mostrará la tabla de Funciones)
SELECT f.id, p.titulo, f.fecha, f.hora, f.sala, f.precio, f.cupos_disponibles
FROM funciones f
JOIN peliculas p ON p.id = f.pelicula_id
ORDER BY f.fecha, f.hora;

-- 2) Historial de compras (reporte del cajero)
SELECT c.id, c.fecha_compra, c.nombre_cliente, p.titulo, c.cantidad_boletos, c.valor_total
FROM compras c
JOIN funciones f ON f.id = c.funcion_id
JOIN peliculas p ON p.id = f.pelicula_id
ORDER BY c.fecha_compra DESC;

-- 3) Ventas por rango de fechas (ajuste las fechas)
SELECT DATE(fecha_compra) AS dia, COUNT(*) AS compras,
       SUM(cantidad_boletos) AS boletos, SUM(valor_total) AS total
FROM compras
WHERE fecha_compra >= DATE '2026-01-01' AND fecha_compra < DATE '2027-01-01'
GROUP BY DATE(fecha_compra)
ORDER BY dia;
