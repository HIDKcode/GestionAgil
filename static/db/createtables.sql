
-- Crear tabla de usuarios
CREATE TABLE IF NOT EXISTS usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario TEXT UNIQUE NOT NULL,
    clave TEXT NOT NULL,
    rol TEXT NOT NULL CHECK (rol IN ('admin', 'trabajador')),
    intentos_fallidos INTEGER DEFAULT 0,
    bloqueado INTEGER DEFAULT 0
);

-- Crear tabla de proveedores
CREATE TABLE IF NOT EXISTS proveedores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    contacto TEXT,
    condiciones_pago TEXT
);

-- Crear tabla de piezas
CREATE TABLE IF NOT EXISTS piezas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    categoria TEXT,
    stock INTEGER DEFAULT 0,
    umbral_minimo INTEGER DEFAULT 0,
    fecha_vencimiento DATE,
    proveedor_id INTEGER,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

-- Crear tabla de historial de precios
CREATE TABLE IF NOT EXISTS precios_anteriores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pieza_id INTEGER NOT NULL,
    precio NUMERIC NOT NULL,
    fecha_actualizacion DATE DEFAULT (DATE('now')),
    FOREIGN KEY (pieza_id) REFERENCES piezas(id)
);

-- Crear tabla de kits
CREATE TABLE IF NOT EXISTS kits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    descripcion TEXT
);

-- Crear tabla de relación entre kits y piezas
CREATE TABLE IF NOT EXISTS kits_piezas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    kit_id INTEGER NOT NULL,
    pieza_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    FOREIGN KEY (kit_id) REFERENCES kits(id),
    FOREIGN KEY (pieza_id) REFERENCES piezas(id)
);

-- Crear tabla de órdenes de compra
CREATE TABLE IF NOT EXISTS ordenes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pieza_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_creacion DATE DEFAULT (DATE('now')),
    estado TEXT DEFAULT 'pendiente',
    aprobado_por INTEGER,
    FOREIGN KEY (pieza_id) REFERENCES piezas(id),
    FOREIGN KEY (aprobado_por) REFERENCES usuarios(id)
);

-- Crear tabla de errores o auditoría
CREATE TABLE IF NOT EXISTS errores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER,
    mensaje TEXT,
    origen_html TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);
