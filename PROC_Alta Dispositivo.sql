-- Active: 1735395480593@@127.0.0.1@3306@teleco
CREATE PROCEDURE nuevo_dispositivo(
    IN p_imei VARCHAR(15),
    IN p_modelo VARCHAR (50),
    IN p_icc VARCHAR (19),
    IN p_dniusuario VARCHAR (9),
    IN p_tipo VARCHAR (50)
)
BEGIN
    -- Declarar transacción
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
    END;
    START TRANSACTION;

    -- Se inserta nuevo dispositivo si no existe
    IF NOT EXISTS (SELECT 1 FROM dispositivo WHERE imei = p_imei) THEN
        INSERT INTO dispositivo (imei, usuario_id, modelo_id, sim_id, tipo_id) 
        VALUES (
            p_imei, 
            (SELECT id FROM usuario WHERE dni = p_dniusuario),
            (SELECT id FROM modelodisp WHERE nombre = p_modelo),
            (SELECT id FROM sim WHERE icc = p_icc),
            (SELECT id FROM tipo_dispositivo WHERE descripcion = p_tipo)
            );
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El dispositivo ya existe';
    END IF;


END