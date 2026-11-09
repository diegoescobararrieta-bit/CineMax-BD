-- =====================================================================
-- CineMax - Sistema de Taquilla de Cine
-- Script 01: Creación de la base de datos
-- Motor: PostgreSQL
-- Ejecutar conectado a la base de datos "postgres" (no a cinemax).
-- En DBeaver: ejecutar con Alt+X (script) y no con Ctrl+Enter.
-- =====================================================================

CREATE DATABASE cinemax
    WITH ENCODING = 'UTF8'
         TEMPLATE = template0;

-- Después de crearla, conéctese a "cinemax" (en DBeaver: cambie la base
-- activa o edite la conexión) antes de ejecutar los scripts 02 en adelante.
