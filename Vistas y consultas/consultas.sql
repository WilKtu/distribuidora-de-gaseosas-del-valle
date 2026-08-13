-- ============================================================

-- SCRIPT DE INSERCIÓN DE DATOS
USE gaseosas_del_valle;

-- ======================================================

-- Consulta 1: Consultar los productos con stock por debajo del mínimo
SELECT nombre, stock_actual, stock_minimo 
    FROM productos 
    WHERE stock_actual < stock_minimo;

-- ======================================================

-- Consulta 2: Consultar los pedidos realizados entre dos fechas (BETWEEN)
SELECT id_pedido, fecha_pedido, total_con_iva 
    FROM pedidos 
    WHERE fecha_pedido BETWEEN '2026-01-01' AND '2026-03-31';

-- ======================================================

-- Consulta 3: Listar los productos más vendidos (con JOIN y GROUP BY)
SELECT p.nombre, SUM(dp.cantidad) AS total_vendido
    FROM productos p
    JOIN detalle_pedido dp ON p.id_producto = dp.id_producto
    GROUP BY p.nombre
    ORDER BY total_vendido DESC;

-- ======================================================

-- Consulta 4: Mostrar clientes y la cantidad de pedidos realizados
SELECT c.nombre, COUNT(p.id_pedido) AS cantidad_pedidos
    FROM clientes c
    LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
    GROUP BY c.id_cliente, c.nombre;

-- ======================================================

-- Consulta 5: Buscar clientes por nombre parcial usando LIKE
SELECT nombre, correo 
    FROM clientes 
    WHERE nombre LIKE '%Supermercado%';