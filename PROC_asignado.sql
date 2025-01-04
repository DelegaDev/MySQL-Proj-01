DROP PROCEDURE IF EXISTS asignado;

CREATE PROCEDURE asignado (
    IN p_dni CHAR (9),
    IN p_imei VARCHAR (15),
    IN p_accesorio VARCHAR (100)
    )
BEGIN
    -- Se inicia Transacción para evitar problemas.
        DECLARE EXIT HANDLER FOR SQLEXCEPTION
        BEGIN
            ROLLBACK;
        END;
    START TRANSACTION;
    
        -- Se inserta nuevo usuario si no existe.
        IF NOT EXISTS (SELECT * FROM usuario WHERE dni = p_dni) THEN
            INSERT INTO usuario (dni)
            VALUES (p_dni);
        END IF;
        -- Se inserta nuevo dispositivo si no existe.
        IF NOT EXISTS (SELECT * FROM dispositivo WHERE imei = p_imei) THEN
            INSERT INTO dispositivo (imei) 
            VALUES (p_imei);
        END IF;
        -- Se crea relación entre accesorio y dispositivo.
        INSERT INTO dispositivo_accesorio (dispositivo_id, accesorio_id)
        VALUES (
            (SELECT id FROM dispositivo WHERE imei = p_imei),
            (SELECT id FROM accesorios WHERE descripcion = p_accesorio)
            );
        -- Se crea relación entre usuario y dispositivo, comenzando por declarar una variable
        BEGIN
            DECLARE v_usuario_id INT;
            -- Se obtiene el id del usuario.
            SELECT id INTO v_usuario_id FROM usuario WHERE dni = p_dni;
            -- Se actualiza la tabla usuario con el id del usuario.
            UPDATE dispositivo
            SET usuario_id = v_usuario_id
            WHERE imei = p_imei;
        END;
        -- Se inserta asignación de dispositivo y accesorio.
        BEGIN
            DECLARE v_usuario_id INT;
            DECLARE v_dispositivo_id INT;
            DECLARE v_accesorio_id INT;
            -- Se obtiene el id del usuario.
            SELECT id INTO v_usuario_id FROM usuario WHERE dni = p_dni;
            -- Se obtiene el id del dispositivo.
            SELECT id INTO v_dispositivo_id FROM dispositivo WHERE imei = p_imei;
            -- Se obtiene el id del accesorio.
            SELECT id INTO v_accesorio_id FROM accesorios WHERE descripcion = p_accesorio;
            INSERT INTO asignacion (usuario_id, dispositivo_id, accesorio_id)
            VALUES (v_usuario_id, v_dispositivo_id, v_accesorio_id);
        END;
    -- Se confirma la transacción.
    COMMIT;
END


CALL asignado ('12345678H', '567392837465987', 'cargador');