-- ============================================================

-- VISTA 1: Resumen de pedidos y ventas por sede


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

-- ============================================================

-- VISTA 2: Productos con stock bajo el mínimo


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

-- ============================================================

-- VISTA 3: Clientes con al menos un pedido registrado


CREATE OR REPLACE VIEW vista_clientes_activos AS
SELECT
    c.id,
    c.nombre,
    c.identificacion,
    c.direccion,
    c.telefono,
    c.correo,
    COUNT(p.id_pedido) AS total_pedidos,
    SUM(p.total_con_iva) AS total_comprado
FROM clientes c
INNER JOIN pedidos p
    ON c.id = p.id_cliente
GROUP BY
    c.id,
    c.nombre,
    c.identificacion,
    c.direccion,
    c.telefono,
    c.correo;
