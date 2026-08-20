/* 
Realizar una consulta con subconsulta que:

Muestre el nombre del producto, categoría y stock

Solo incluya los productos cuyo precio sea mayor al promedio general de precios de todos los productos.

Crear un trigger llamado auditar_cambio_precio que:
Se ejecute después de un UPDATE en la tabla de productos.
*/

SELECT nombre, categorias, stock_actual
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

DELIMITER //

CREATE TRIGGER auditar_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_cambios (id_producto, precio_anterior, precio_nuevo, fecha_cambio)
    VALUES (OLD.id_producto, OLD.precio, NEW.precio, NOW());
END //  

DELIMITER ;

