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