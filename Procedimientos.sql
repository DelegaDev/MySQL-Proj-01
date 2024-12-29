-- Active: 1735395480593@@127.0.0.1@3306@teleco
CREATE DEFINER=`root`@`localhost` PROCEDURE `nuevo_ususario`(
    IN p_dni CHAR (9),
    IN p_nombre VARCHAR (20),
    IN p_apellido VARCHAR (50),
    IN p_tip INT (11),
    IN p_plantillas_id INT (11)
)
BEGIN
    -- Se inicia Transacción para evitar problemas.
    START TRANSACTION;
    BEGIN
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;
        -- Se inserta el nuevo usuario.
        INSERT INTO usuario (dni, nombre, apellido, tip, plantillas_id)
        VALUES (p_dni, p_nombre, p_apellido, p_tip, p_plantillas_id);
        -- Se confirma la transacción.
        COMMIT;
    END;
END
-- Ejecutando el procedimiento almacenado
CALL nuevo_ususario('12345678A', 'Juan', 'Perez', 89456, 1);