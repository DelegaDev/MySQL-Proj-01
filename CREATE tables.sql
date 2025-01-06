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

# Creando tabla de tarjeta sim con relación a la tabla linea 
CREATE TABLE sim (
    id INT (11) NOT NULL AUTO_INCREMENT,
    icc VARCHAR (19) NOT NULL,
    pin VARCHAR (4),
    puk VARCHAR (10),
    linea_id INT (11) NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (linea_id) REFERENCES linea (id);
);
# Adding
CREATE TABLE linea (
    id INT (11) NOT NULL AUTO_INCREMENT,
    numero VARCHAR (12) NOT NULL,
    corto VARCHAR (6),
    multisim BOOLEAN NOT NULL,
    PRIMARY KEY (id)
);
# Añadiendo clave foranea a la tabla dispositivo ya que puede tener mas de una SIM
ALTER TABLE dispositivo
ADD FOREIGN KEY (sim_id) REFERENCES sim (id);

-- Creando tabla de recepción de dispositivo y/o accesorio
CREATE TABLE recepcion (
    fecha DATETIME NOT NULL,
    usuario_id INT NOT NULL,
    dispositivo_id INT NOT NULL,
    accesorio_id INT NOT NULL,
    PRIMARY KEY (usuario_id, dispositivo_id, accesorio_id),
    FOREIGN KEY (usuario_id) REFERENCES usuario (id),
    FOREIGN KEY (dispositivo_id) REFERENCES dispositivo (id),
    FOREIGN KEY (accesorio_id,dispositivo_id) REFERENCES dispositivo_accesorio (accesorio_id,dispositivo_id)
);