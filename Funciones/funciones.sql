-- =====================================================================

-- Funcion 1: FUNCIÓN DE CÁLCULO FINANCIERO

DELIMITER //
CREATE FUNCTION fn_calcular_total_con_iva(p_id_pedido INT) 
RETURNS DECIMAL(10, 2)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_total_sin_iva DECIMAL(10, 2);
    DECLARE v_total_con_iva DECIMAL(10, 2);
    DECLARE v_tasa_iva DECIMAL(3, 2) DEFAULT 0.19; -- 19%
    SELECT COALESCE(SUM(subtotal), 0) 
        INTO v_total_sin_iva
        FROM detalle_pedido
        WHERE id_pedido = p_id_pedido;
    
    SET v_total_con_iva = v_total_sin_iva * (1 + v_tasa_iva);
    RETURN ROUND(v_total_con_iva, 2);
END //

DELIMITER ;

SELECT fn_calcular_total_con_iva(1);

