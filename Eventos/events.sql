-- ============================================================

-- SCRIPT DE INSERCIÓN DE DATOS
USE gaseosas_del_valle;

-- Evento: Reposición automática de inventario

-- ============================================================

SET GLOBAL event_scheduler = ON;

DELIMITER //

CREATE EVENT ev_reponer_stock
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN

    UPDATE productos
    SET stock_actual = stock_actual + 50
    WHERE stock_actual < stock_minimo;

END //

DELIMITER ;