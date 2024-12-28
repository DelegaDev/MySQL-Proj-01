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