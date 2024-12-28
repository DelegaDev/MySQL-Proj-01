-- Active: 1734873719795@@127.0.0.1@3306@teleco
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
)
