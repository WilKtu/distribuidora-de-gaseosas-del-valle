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