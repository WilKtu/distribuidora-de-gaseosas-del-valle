/* Muestre por cada sede:
Nombre de la sede
Cantidad total de pedidos despachados
Valor total vendido (sin IVA)

Promedio de valor por pedido

La vista debe usar JOIN entre pedidos y sedes, y agrupar correctamente los resultados.*/

CREATE VIEW vista_sedes_pedidos AS SELECT s.nombre AS nombre_sede,
       COUNT(p.id_pedido) AS cantidad_pedidos,
       SUM(p.total_sin_iva) AS valor_total_vendido,
       AVG(p.total_sin_iva) AS promedio_valor_por_pedido
FROM sedes s
JOIN pedidos p ON s.id_sede = p.id_sede
GROUP BY s.nombre;