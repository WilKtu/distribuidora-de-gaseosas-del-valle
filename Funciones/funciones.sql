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

-- =====================================================================

-- Funcion 2: FUNCIÓN DE VALIDACIÓN DE INVENTARIO

DELIMITER //

CREATE FUNCTION fn_validar_stock(p_id_producto INT, p_cantidad INT) 
RETURNS VARCHAR(150)
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_stock_actual INT;
    DECLARE v_nombre_producto VARCHAR(100);
    DECLARE v_mensaje VARCHAR(150);
    SELECT stock_actual, nombre 
        INTO v_stock_actual, v_nombre_producto
        FROM productos
        WHERE id_producto = p_id_producto;

    IF v_stock_actual IS NULL THEN
        SET v_mensaje = 'ERROR: El producto con el ID proporcionado no existe en el inventario.';      
    ELSEIF p_cantidad <= 0 THEN
        SET v_mensaje = 'ERROR: La cantidad solicitada debe ser un número mayor a cero.';
    ELSEIF v_stock_actual >= p_cantidad THEN
        SET v_mensaje = CONCAT('APROBADO: Stock suficiente de "', v_nombre_producto, '". (Disponible: ', v_stock_actual, ' unidades).');
    ELSE
        SET v_mensaje = CONCAT('RECHAZADO: Stock insuficiente de "', v_nombre_producto, '". Solicitado: ', p_cantidad, ' | Disponible: ', v_stock_actual);
    END IF;
    RETURN v_mensaje;
END //

DELIMITER ;

SELECT fn_validar_stock(1);