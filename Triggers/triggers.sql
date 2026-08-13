-- ============================================================

-- Trigger 1: Actualizar stock después de registrar un detalle


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