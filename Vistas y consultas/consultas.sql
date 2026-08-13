-- ============================================================

-- SCRIPT DE INSERCIÓN DE DATOS
USE gaseosas_del_valle;

-- ======================================================

-- Consulta 1: Consultar los productos con stock por debajo del mínimo
SELECT nombre, stock_actual, stock_minimo 
FROM productos 
WHERE stock_actual < stock_minimo;