-- Usuarios y roles para login y permisos
CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario TEXT UNIQUE NOT NULL,
    clave TEXT NOT NULL,
    rol TEXT NOT NULL CHECK (rol IN ('admin', 'trabajador')),
    intentos_fallidos INTEGER DEFAULT 0,
    bloqueado INTEGER DEFAULT 0
);

-- Proveedores de piezas
CREATE TABLE proveedores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    contacto TEXT,
    condiciones_pago TEXT
);

-- Inventario de piezas/componentes
CREATE TABLE piezas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    categoria TEXT,
    stock INTEGER DEFAULT 0,
    umbral_minimo INTEGER DEFAULT 0,
    fecha_vencimiento DATE,
    proveedor_id INTEGER,
    FOREIGN KEY (proveedor_id) REFERENCES proveedores(id)
);

-- Historial de precios de piezas para trazabilidad
CREATE TABLE precios_anteriores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pieza_id INTEGER NOT NULL,
    precio NUMERIC NOT NULL,
    fecha_actualizacion DATE DEFAULT (DATE('now')),
    FOREIGN KEY (pieza_id) REFERENCES piezas(id)
);

-- Kits o proyectos (ensamblajes)
CREATE TABLE kits (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL,
    descripcion TEXT
);

-- Relación muchos a muchos entre kits y piezas, con cantidades
CREATE TABLE kits_piezas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    kit_id INTEGER NOT NULL,
    pieza_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    FOREIGN KEY (kit_id) REFERENCES kits(id),
    FOREIGN KEY (pieza_id) REFERENCES piezas(id)
);

-- Órdenes de compra generadas automáticamente
CREATE TABLE ordenes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    pieza_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL,
    fecha_creacion DATE DEFAULT (DATE('now')),
    estado TEXT DEFAULT 'pendiente',
    aprobado_por INTEGER,
    FOREIGN KEY (pieza_id) REFERENCES piezas(id),
    FOREIGN KEY (aprobado_por) REFERENCES usuarios(id)
);

-- Registro de errores o alertas para auditoría
CREATE TABLE errores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER,
    mensaje TEXT,
    origen_html TEXT,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
);