-- Insertar usuarios
INSERT INTO usuarios (usuario, clave, rol) VALUES ('admin', 'admin', 'admin');
INSERT INTO usuarios (usuario, clave, rol) VALUES ('trabajador', 'trabajador', 'trabajador');

-- Insertar algunos proveedores de ejemplo
INSERT INTO proveedores (nombre, contacto, condiciones_pago) VALUES ('Proveedor A', 'contacto@proveedora.com', '30 días');
INSERT INTO proveedores (nombre, contacto, condiciones_pago) VALUES ('Proveedor B', 'contacto@proveedorb.com', 'Contado');

-- Insertar algunas piezas (items)
INSERT INTO piezas (nombre, categoria, stock, umbral_minimo, fecha_vencimiento, proveedor_id) VALUES
('Tornillo M4', 'Ferretería', 100, 20, '2026-12-31', 1),
('Tuerca M4', 'Ferretería', 150, 30, '2027-01-15', 1),
('Motor eléctrico', 'Electrónica', 10, 2, NULL, 2),
('Batería 12V', 'Electrónica', 25, 5, '2025-11-30', 2);