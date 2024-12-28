-- Active: 1735395480593@@127.0.0.1@3306@teleco
-- Script Name: New_Query_1735387361748.sql
-- Script Type : Create and modify tables 
-- Develop By: Delega Dev
-- Date Created: 28 Dec 2024
-- Modify Date: 28 Dec 2024
-- Version    : 1.0
-- Notes : 
-- Description:

# Creación de la tabla de unión entre usuario y correo
CREATE TABLE usuario_correo (
    usuario_id INT NOT NULL,
    correo_id INT NOT NULL,
    PRIMARY KEY (usuario_id, correo_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario (id),
    FOREIGN KEY (correo_id) REFERENCES correo (id)
);
# Inserción de datos en la tabla de correos
INSERT INTO correo (email, tipo)
VALUES 
    ('alfa@gmail.com', 'exchange'),
    ('beta@gmail.com', 'POP3'),
    ('gamma@gmail.com', 'IMAP'),
    ('dado@gmail.com', 'POP3');
    
# Inserción de datos en la tabla de unión entre usuarios y sus correos
INSERT INTO usuario_correo (usuario_id, correo_id) 
VALUES 
(1, 4),
(2, 3),
(3, 2),
(4, 1); 

# Consulta de los usuarios con sus correos
SELECT U.nombre, U.apellido, C.email, C.tipo FROM usuario U
JOIN usuario_correo UC ON U.id = UC.usuario_id
JOIN correo C ON UC.correo_id = C.id;

# Creando tabla de marcas de dispositivos
CREATE TABLE marcaDisp (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
);

# Creando tabla modelo de marcas de dispositivos
CREATE TABLE modeloDisp (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    marca_id INT NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (marca_id) REFERENCES marcaDisp (id)
);

# Inserción de datos en la tabla de marcas de dispositivos
INSERT INTO marcaDisp (nombre) VALUES ('Samsung');

# Inserción de datos en la tabla de modelos de dispositivos
INSERT INTO modeloDisp (nombre, marca_id)
VALUES
('Galaxy A10', 1),
('Galaxy A11', 1),
('Galaxy A12', 1),
('Galaxy A13', 1),
('Galaxy A14', 1),
('Galaxy A15', 1),
('Galaxy Tab A9', 1);

# Modificando la tabla dispositivo para crear relación con modeloDisp
ALTER TABLE dispositivo
ADD COLUMN modelo_id INT NOT NULL
ADD FOREIGN KEY (modelo_id) REFERENCES modelodisp (id);