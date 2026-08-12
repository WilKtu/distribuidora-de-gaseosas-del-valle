-- Crear el usuario
CREATE USER 'desarrollador'@'localhost'
IDENTIFIED BY 'Desarrollador123*';

-- Dar permisos sobre la base de datos
GRANT
    SELECT, INSERT,
    UPDATE, DELETE,
    CREATE, ALTER,
    INDEX, CREATE VIEW,
    SHOW VIEW, CREATE ROUTINE,
    ALTER ROUTINE, EXECUTE,
    TRIGGER, EVENT
ON gaseosas_del_valle*
TO 'desarrollador'@'localhost';