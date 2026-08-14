# 🥤 Distribuidora de gaseosas el valle
## Base de Datos: `gaseosas_del_valle`

> Proyecto desarrollado en MySQL para administrar inventarios, clientes, pedidos, sedes y auditoría de precios de la empresa **Gaseosas del Valle**.

---

## 📚 Tabla de Contenidos

- [Descripción General](#-descripción-general)
- [Características](#-características)
- [Tecnologías Utilizadas](#-tecnologías-utilizadas)
- [Estructura de la Base de Datos](#-estructura-de-la-base-de-datos)
- [Modelo Entidad-Relación](#-modelo-entidad-relación)
- [Control de Acceso](#-control-de-acceso)
- [Carga de Datos](#-carga-de-datos)
- [Consultas SQL](#-consultas-sql)
- [Eventos](#-eventos)
- [Triggers](#-triggers)
- [Vistas](#-vistas)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Autor](#-autor)

---

# 📖 Descripción General

El proyecto implementa una base de datos relacional para la empresa **Gaseosas del Valle**, permitiendo administrar productos, clientes, pedidos, inventario y auditoría de precios mediante objetos avanzados de MySQL como procedimientos, eventos, triggers y vistas.

La arquitectura está diseñada para garantizar la integridad referencial, la automatización de procesos críticos y la trazabilidad completa de las operaciones comerciales.

---

# 🚀 Características

- **Gestión de productos**: Catálogo completo con categorías, precios, volúmenes y control de stock
- **Gestión de clientes**: Base de datos de clientes con información de contacto y ubicación
- **Gestión de sedes**: Múltiples puntos de venta con capacidad y encargado asignado
- **Registro de pedidos**: Sistema de pedidos con cálculo automático de IVA
- **Auditoría automática de precios**: Historial completo de cambios de precios
- **Actualización automática del stock**: Triggers que ajustan el inventario en tiempo real
- **Consultas analíticas**: Reportes de ventas, productos más vendidos y análisis por sede
- **Vistas para reportes**: Interfaces simplificadas para consulta de información compleja

---

# 💻 Tecnologías Utilizadas

- **MySQL 8.x**: Sistema de gestión de bases de datos relacional
- **SQL**: Lenguaje estructurado de consultas
- **GitHub Markdown**: Documentación del proyecto

---

# 🏗️ Estructura de la Base de Datos

## Tablas

| Tabla | Descripción | Campos Principales |
|--------|-------------|-------------------|
| `productos` | Catálogo de bebidas | id_producto, nombre, categoria, precio, volumen_ml, stock_actual, stock_minimo |
| `clientes` | Información de clientes | id, nombre, identificacion, direccion, telefono, correo |
| `sedes` | Sucursales y puntos de venta | id_sede, nombre, ubicacion, capacidad, encargado |
| `pedidos` | Encabezado de pedidos | id_pedido, fecha_pedido, id_cliente, id_sede, total_sin_iva, total_con_iva |
| `detalle_pedido` | Productos vendidos por pedido | id_pedido, id_producto, cantidad, subtotal |
| `auditoria_precios` | Historial de cambios de precios | id_auditoria, id_producto, precio_anterior, precio_nuevo, fecha_cambio |

---

# 🔗 Modelo Entidad-Relación
![diagrama](/diagrama.png)

# 🔐 Control de Acceso

## Creación de Usuario

Se crea un usuario específico para desarrollo con acceso local:

```sql
CREATE USER 'desarrollador'@'localhost'
IDENTIFIED BY 'Desarrollador123*';
```

## Permisos Asignados

Se otorgan permisos completos sobre la base de datos `gaseosas_del_valle`:

```sql
GRANT
    SELECT,
    INSERT,
    UPDATE,
    DELETE,
    CREATE,
    ALTER,
    INDEX,
    CREATE VIEW,
    SHOW VIEW,
    CREATE ROUTINE,
    ALTER ROUTINE,
    EXECUTE,
    TRIGGER,
    EVENT
ON gaseosas_del_valle.*
TO 'desarrollador'@'localhost';
```

### Descripción de Permisos

| Permiso | Función |
|---------|---------|
| `SELECT` | Consultar datos |
| `INSERT` | Insertar nuevos registros |
| `UPDATE` | Modificar registros existentes |
| `DELETE` | Eliminar registros |
| `CREATE` | Crear tablas y objetos |
| `ALTER` | Modificar estructura de tablas |
| `INDEX` | Crear y eliminar índices |
| `CREATE VIEW` | Crear vistas |
| `SHOW VIEW` | Ver definición de vistas |
| `CREATE ROUTINE` | Crear procedimientos y funciones |
| `ALTER ROUTINE` | Modificar procedimientos y funciones |
| `EXECUTE` | Ejecutar procedimientos y funciones |
| `TRIGGER` | Crear y gestionar triggers |
| `EVENT` | Crear eventos programados |

## Aplicación de Cambios

```sql
FLUSH PRIVILEGES;
```

---

# 📦 Carga de Datos

El sistema incluye datos de prueba para todas las tablas:

| Tabla | Cantidad de Registros |
|-------|----------------------|
| productos | 62 productos |
| clientes | 30 clientes |
| sedes | 16 sedes |
| pedidos | 39 pedidos |
| detalle_pedido | 39 detalles |
| auditoria_precios | 50 registros de auditoría |

### Distribución de Productos por Categoría

- **Gaseosas**: Variedad de sabores (Cola, Naranja, Limón, Uva, Manzana)
- **Sodas**: Diferentes presentaciones
- **Aguas**: Mineral, con gas y saborizadas
- **Especialidades**: Kombucha, energizantes, malta, té helado
- **Presentaciones**: 330ml, 500ml, 1000ml, 1500ml, 2000ml

---

# 🔍 Consultas SQL

## 1. Productos con Stock Bajo

Identifica productos cuyo stock actual está por debajo del mínimo requerido:

```sql
SELECT nombre, stock_actual, stock_minimo 
FROM productos 
WHERE stock_actual < stock_minimo;
```

---

## 2. Pedidos por Rango de Fechas

Consulta pedidos realizados en un período específico usando `BETWEEN`:

```sql
SELECT id_pedido, fecha_pedido, total_con_iva 
FROM pedidos 
WHERE fecha_pedido BETWEEN '2026-01-01' AND '2026-03-31';
```

---

## 3. Productos Más Vendidos

Lista productos ordenados por cantidad vendida usando `JOIN` y `GROUP BY`:

```sql
SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
FROM productos p
JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
GROUP BY p.nombre
ORDER BY total_vendido DESC;
```

---

## 4. Clientes y Cantidad de Pedidos

Muestra clientes con el total de pedidos realizados usando `LEFT JOIN`:

```sql
SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre;
```

---

## 5. Búsqueda de Clientes por Nombre

Busca clientes cuyo nombre contenga una palabra específica usando `LIKE`:

```sql
SELECT nombre, correo 
FROM clientes 
WHERE nombre LIKE '%Supermercado%';
```

---

## 6. Productos por Categoría

Filtra productos de categorías específicas usando `IN`:

```sql
SELECT nombre, categoria, precio
FROM productos
WHERE categoria IN ('Gaseosa', 'Soda', 'Agua');
```

---

## 7. Cliente con Mayor Número de Pedidos

Identifica el cliente que más pedidos ha realizado usando subconsulta:

```sql
SELECT nombre 
FROM clientes 
WHERE id_cliente = (
    SELECT id_cliente 
    FROM pedidos 
    GROUP BY id_cliente 
    ORDER BY COUNT(id_pedido) DESC 
    LIMIT 1
);
```

---

## 8. Ingresos Totales por Sede

Muestra ingresos agrupados por sede con cálculo de totales:

```sql
SELECT s.nombre AS sede, SUM(p.total_con_iva) AS ingresos_totales
FROM sedes s
JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.nombre
ORDER BY ingresos_totales DESC;
```

---

# ⚙️ Eventos

## Reposición Automática de Stock

Evento programado que se ejecuta diariamente para reponer stock de productos con inventario bajo:

```sql
SET GLOBAL event_scheduler = ON;

DELIMITER //

CREATE EVENT ev_reponer_stock
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    UPDATE productos
    SET stock_actual = stock_actual + 50
    WHERE stock_actual < stock_minimo;
END //

DELIMITER ;
```

**Funcionalidad:**
- Se ejecuta automáticamente cada 24 horas
- Identifica productos con stock por debajo del mínimo
- Incrementa el stock actual en 50 unidades
- Previene desabastecimiento automático

---

# 🔔 Triggers

## 1. Actualización Automática de Stock

Trigger que ajusta el inventario cuando se registra un nuevo detalle de pedido:

```sql
DELIMITER //

CREATE TRIGGER tr_actualizar_stock
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN
    UPDATE productos
    SET stock_actual = stock_actual - NEW.cantidad
    WHERE id_producto = NEW.id_producto;
END //

DELIMITER ;
```

**Funcionalidad:**
- Se activa después de insertar un detalle de pedido
- Resta la cantidad vendida del stock del producto
- Mantiene el inventario actualizado en tiempo real
- Garantiza consistencia de datos

**Verificación:**
```sql
-- Antes de la venta
SELECT stock_actual FROM productos WHERE id_producto = 1;

-- Registrar venta
INSERT INTO detalle_pedido (id_pedido, id_producto, cantidad, subtotal)
VALUES (1, 1, 5, 17.50);

-- Después de la venta
SELECT stock_actual FROM productos WHERE id_producto = 1;
```

---

## 2. Auditoría de Cambios de Precio

Trigger que registra automáticamente cualquier cambio en los precios:

```sql
DELIMITER //

CREATE TRIGGER tr_auditar_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    IF OLD.precio <> NEW.precio THEN
        INSERT INTO auditoria_precios (
            id_producto,
            precio_anterior,
            precio_nuevo,
            fecha_cambio
        )
        VALUES (
            NEW.id_producto,
            OLD.precio,
            NEW.precio,
            NOW()
        );
    END IF;
END //

DELIMITER ;
```

**Funcionalidad:**
- Se activa después de actualizar un producto
- Verifica si el precio ha cambiado
- Registra precio anterior, nuevo precio y fecha del cambio
- Proporciona trazabilidad completa de ajustes de precios

**Verificación:**
```sql
-- Actualizar precio
UPDATE productos SET precio = 4.00 WHERE id_producto = 1;

-- Consultar auditoría
SELECT * FROM auditoria_precios ORDER BY id_auditoria DESC;
```

---

# 📊 Vistas

## 1. Resumen de Pedidos por Sede

Vista que consolida información de ventas por sede:

```sql
CREATE VIEW vista_resumen_pedidos_por_sede AS
SELECT 
    s.id_sede,
    s.nombre AS nombre_sede,
    s.ubicacion,
    s.encargado,
    COUNT(p.id_pedido) AS total_pedidos,
    COALESCE(SUM(p.total_sin_iva), 0) AS total_ventas_sin_iva,
    COALESCE(SUM(p.total_con_iva), 0) AS total_ventas_con_iva
FROM sedes s
LEFT JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.id_sede, s.nombre, s.ubicacion, s.encargado;
```

**Uso:**
```sql
SELECT * FROM vista_resumen_pedidos_por_sede;
```

---

## 2. Productos con Stock Bajo

Vista que identifica productos que requieren reposición:

```sql
CREATE VIEW vista_productos_bajo_stock AS
SELECT 
    id_producto,
    nombre,
    categoria,
    precio,
    volumen_ml,
    stock_actual,
    stock_minimo,
    (stock_minimo - stock_actual) AS unidades_faltantes
FROM productos
WHERE stock_actual <= stock_minimo
ORDER BY unidades_faltantes DESC;
```

**Uso:**
```sql
SELECT * FROM vista_productos_bajo_stock;
```

---

## 3. Clientes Activos

Vista que muestra clientes con al menos un pedido registrado:

```sql
CREATE OR REPLACE VIEW vista_clientes_activos AS
SELECT 
    c.id_cliente,
    c.nombre,
    c.identificacion,
    c.direccion,
    c.telefono,
    c.correo,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(p.total_con_iva) AS total_comprado
FROM clientes c
INNER JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente, c.nombre, c.identificacion, c.direccion, c.telefono, c.correo;
```

**Uso:**
```sql
SELECT * FROM vista_clientes_activos;
```

---

# 📋 Requisitos

- **MySQL 8.0 o superior**
- **Event Scheduler habilitado**: `SET GLOBAL event_scheduler = ON;`
- **Soporte para Triggers**
- **Soporte para Vistas**
- **Permisos de administrador** para configuración inicial

---

# ⚙️ Instalación

## Paso 1: Crear la base de datos

```sql
CREATE DATABASE IF NOT EXISTS gaseosas_del_valle;
USE gaseosas_del_valle;
```

## Paso 2: Crear usuario y asignar permisos

```sql
CREATE USER 'desarrollador'@'localhost' IDENTIFIED BY 'Desarrollador123*';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, INDEX, 
      CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, 
      EXECUTE, TRIGGER, EVENT 
ON gaseosas_del_valle.* TO 'desarrollador'@'localhost';
FLUSH PRIVILEGES;
```

## Paso 3: Ejecutar scripts en orden

```sql
SOURCE ddl.sql;           -- Estructura de tablas
SOURCE inserts.sql;       -- Carga de datos
SOURCE consultas.sql;     -- Consultas predefinidas
SOURCE eventos.sql;       -- Eventos programados
SOURCE triggers.sql;      -- Triggers
SOURCE vistas.sql;        -- Vistas
```

## Paso 4: Habilitar Event Scheduler

```sql
SET GLOBAL event_scheduler = ON;
```

---

# 👨‍💻 Autor

**Fernando Colaj**

Proyecto académico de Bases de Datos

---

## 📝 Notas Adicionales

- Este sistema está diseñado para escalar y puede adaptarse a requisitos empresariales más complejos
- Los triggers garantizan la integridad transaccional automáticamente
- Las vistas simplifican el acceso a información compleja
- Los eventos programados reducen la necesidad de intervención manual
- La auditoría de precios proporciona trazabilidad completa para cumplimiento normativo

---

**Versión del Documento:** 1.0  
**Fecha de Creación:** Agosto 2026  
**Base de Datos:** gaseosas_del_valle
