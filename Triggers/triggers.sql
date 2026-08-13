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

-- Trigger 2: Registrar cambios de precio

-- ============================================================

DELIMITER //

CREATE TRIGGER tr_auditar_cambio_precio
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN

    IF OLD.precio <> NEW.precio THEN

        INSERT INTO auditoria_precios
        (
            id_producto,
            precio_anterior,
            precio_nuevo,
            fecha_cambio
        )
        VALUES
        (
            NEW.id_producto,
            OLD.precio,
            NEW.precio,
            NOW()
        );

    END IF;

END //

DELIMITER ;