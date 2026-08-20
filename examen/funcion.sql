/*
Crear una función MySQL llamada calcular_promedio_pedidos_cliente que:

Reciba como parámetro el ID de un cliente.

Retorne el promedio del total (sin IVA) de todos 
los pedidos realizados por ese cliente.

Si el cliente no tiene pedidos, retorne 0.*/

DELIMITER //

CREATE FUNCTION calcular_promedio_pedidos_cliente(c_id_cliente INT)
RETURNS DECIMAL(10,2)
BEGIN
    SELECT nombre, COUNT(p.id_pedido) AS cantidad_pedidos, AVG(p.total_sin_iva) AS promedio_total_sin_iva
    FROM clientes c
    LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
    WHERE c.id_cliente = c_id_cliente
    GROUP BY c.id_cliente, c.nombre;
END //

DELIMITER ;
