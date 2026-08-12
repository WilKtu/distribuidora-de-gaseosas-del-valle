-- Crear el usuario
CREATE USER 'desarrollador'@'localhost'
IDENTIFIED BY 'Desarrollador123*';

-- Dar permisos sobre la base de datos
GRANT
    SELECT, INSERT,
    UPDATE, DELETE,
    CREATE, ALTER,
    INDEX, CREATE VIEW,
    SHOW VIEW, CREATE ROUTINE,
    ALTER ROUTINE, EXECUTE,
    TRIGGER, EVENT
ON gaseosas_del_valle*
TO 'desarrollador'@'localhost';

-- Aplicar los cambios
FLUSH PRIVILEGES;

-- ============================================================

-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS gaseosas_del_valle;

USE gaseosas_del_valle;

-- ============================================================

-- Tabla: productos
CREATE TABLE productos(
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    volumen_ml INT NOT NULL,
    stock_actual INT NOT NULL,
    stock_minimo INT NOT NULL
);

-- ============================================================

-- Tabla: clientes
CREATE TABLE clientes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    identificacion VARCHAR(20) NOT NULL,
    direccion VARCHAR(100) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    correo VARCHAR(100)
);

-- ============================================================

-- Tabla: sedes
CREATE TABLE sedes(
    id_sede INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100) NOT NULL,
    capacidad INT NOT NULL,
    encargado VARCHAR(100) NOT NULL
);

-- ============================================================

-- Tabla: pedidos
CREATE TABLE pedidos(
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    fecha_pedido DATE NOT NULL,
    id_cliente INT,
    id_sede INT,
    total_sin_iva DECIMAL(10,2),
    total_con_iva DECIMAL(10,2)
);

-- ============================================================

-- Tabla: detalle_pedido
CREATE TABLE detalle_pedido(
    id_pedido INT,
    id_producto INT,
    cantidad INT NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    PRIMARY KEY(id_pedido, id_producto)
);

-- ============================================================

-- Tabla: auditoria_precios
CREATE TABLE auditoria_precios(
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_producto INT,
    precio_anterior DECIMAL(10,2),
    precio_nuevo DECIMAL(10,2),
    fecha_cambio DATE
);

-- ============================================================

-- Relaciones entre las tablas

-- Un pedido pertenece a un cliente.
ALTER TABLE pedidos
ADD CONSTRAINT fk_pedido_cliente
FOREIGN KEY (id_cliente)
REFERENCES clientes(id);

-- Un pedido pertenece a una sede.
ALTER TABLE pedidos
ADD CONSTRAINT fk_pedido_sede
FOREIGN KEY (id_sede)
REFERENCES sedes(id_sede);

-- Cada detalle pertenece a un pedido.
ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_pedido
FOREIGN KEY (id_pedido)
REFERENCES pedidos(id_pedido);

-- Cada detalle hace referencia a un producto.
ALTER TABLE detalle_pedido
ADD CONSTRAINT fk_detalle_producto
FOREIGN KEY (id_producto)
REFERENCES productos(id_producto);

-- La auditoría pertenece a un producto.
ALTER TABLE auditoria_precios
ADD CONSTRAINT fk_auditoria_producto
FOREIGN KEY (id_producto)
REFERENCES productos(id_producto);