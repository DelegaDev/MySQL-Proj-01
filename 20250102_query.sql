-- Active: 1735395480593@@127.0.0.1@3306@teleco
SELECT * FROM usuario;
SELECT * FROM dispositivo;
SELECT * FROM tipo_usuario;
SELECT * FROM tipo_dispositivo;
SELECT * FROM recepcion;
SELECT * from correo;

-- eliminar la tabla usuario_dispositivo. Ver remote PRO 2025-01-03
DROP TABLE usuario_dispositivo;

-- añadir usuario_id a la tabla dispositivo
ALTER TABLE dispositivo
ADD COLUMN usuario_id INT (11);

-- Añadir la clave foránea a la tabla dispositivo
ALTER TABLE dispositivo
ADD FOREIGN KEY (usuario_id) REFERENCES usuario (id);

-- Asignando dispositivos a usuarios
UPDATE dispositivo SET usuario_id = 1 WHERE id = 1;
UPDATE dispositivo SET usuario_id = 4 WHERE id = 2;
UPDATE dispositivo SET usuario_id = 2 WHERE id = 3;
UPDATE dispositivo SET usuario_id = 3 WHERE id = 4;
UPDATE dispositivo SET usuario_id = 1 WHERE id = 5;
UPDATE dispositivo SET usuario_id = 4 WHERE id = 6;

ALTER TABLE usuario
ADD COLUMN tipo_id TINYINT (4) NOT NULL DEFAULT 1;

CREATE TABLE tipo_usuario (
    id TINYINT (4) NOT NULL AUTO_INCREMENT,
    tipo VARCHAR (50) NOT NULL,
    PRIMARY KEY (id)
);
-- Añadiendo valores de tipo de usuario Inividial y Departamental
INSERT INTO tipo_usuario (tipo) 
VALUES 
    ('Individual'),
    ('Departamental');
-- Creando relación entre usuario y tipo_usuario
ALTER TABLE usuario
ADD FOREIGN KEY (tipo_id) REFERENCES tipo_usuario (id);
-- Creando table tipo_dispositivo
CREATE TABLE tipo_dispositivo (
    id TINYINT (4) NOT NULL AUTO_INCREMENT,
    tipo VARCHAR (50) NOT NULL,
    PRIMARY KEY (id)
)

-- Añadiendo valores de tipo de dispositivo
INSERT INTO tipo_dispositivo (tipo)
VALUES  
    ('Móvil'),
    ('Tablet'),
    ('MiFi');

-- cambiando propiedades columna tipo en la tabla dispositivo
ALTER TABLE dispositivo
CHANGE COLUMN tipo tipo_id TINYINT (4) NOT NULL;


ALTER TABLE dispositivo
ADD FOREIGN KEY (tipo_id) REFERENCES tipo_dispositivo (id);

--Eliminando la tabla recepción
DROP TABLE recepcion;

CREATE TABLE emails (
    id INT NOT NULL AUTO_INCREMENT,
    email VARCHAR (100) NOT NULL,
    tipo_id TINYINT (4) NOT NULL,
    observaciones VARCHAR (100),
    PRIMARY KEY (id)
);
CREATE TABLE tipo_email (
    id TINYINT (4) NOT NULL AUTO_INCREMENT,
    tipo VARCHAR (50) NOT NULL,
    PRIMARY KEY (id)
);
ALTER TABLE emails
ADD FOREIGN KEY (tipo_id) REFERENCES tipo_email (id);

INSERT INTO tipo_email (tipo)
VALUES
    ('Exchange'),
    ('POP3'),
    ('IMAP');

SELECT * FROM usuario_emails;

INSERT INTO emails (email, tipo_id)
VALUES 
    ('alfa@gmail', 1),
    ('beta@gmail', 2),
    ('gamma@gmail', 3),
    ('delta@gmail', 1);


ALTER TABLE Usuario_emails ADD FOREIGN KEY (emails_id) REFERENCES emails (id);
ALTER TABLE usuario_emails ADD FOREIGN KEY (usuario_id) REFERENCES usuario (id);

-- Creando tabla asignación dispositivo y/o accesorio
CREATE TABLE asignacion (
    usuario_id INT (11) NOT NULL,
    dispositivo_id INT (11) NOT NULL,
    accesorio_id INT (11) NOT NULL,
    fecha DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    observaciones VARCHAR (1000),
    PRIMARY KEY (usuario_id, dispositivo_id, accesorio_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario (id),
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivo (id),
    FOREIGN KEY (accesorio_id) REFERENCES accesorios (id)
)
