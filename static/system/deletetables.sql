-- Borrar tablas en orden inverso de dependencias
DROP TABLE IF EXISTS errores;
DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS kits_piezas;
DROP TABLE IF EXISTS kits;
DROP TABLE IF EXISTS precios_anteriores;
DROP TABLE IF EXISTS piezas;
DROP TABLE IF EXISTS proveedores;
DROP TABLE IF EXISTS usuarios;
DELETE FROM sqlite_sequence;