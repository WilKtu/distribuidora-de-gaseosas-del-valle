-- ============================================================

-- VISTA 1: Resumen de pedidos y ventas por sede


CREATE OR REPLACE VIEW vista_resumen_pedidos_por_sede AS
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