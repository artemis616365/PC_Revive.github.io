-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS db_tallerdereparacion;

-- Usar la base de datos
USE db_tallerdereparacion;

-- Borrar y crear tabla de empleados
DROP TABLE IF EXISTS empleados;
CREATE TABLE empleados (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombres VARCHAR(100) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    correo VARCHAR(100) NOT NULL,
    password VARCHAR(255) NOT NULL,
    puesto ENUM('gerente', 'caja', 'reparador') NOT NULL,
    numtelefonico VARCHAR(20)
);

-- Borrar y crear tabla de clientes
DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    numtelefonico VARCHAR(20),
    direccion VARCHAR(255)
);

-- Borrar y crear tabla de equipos
DROP TABLE IF EXISTS equipos;
CREATE TABLE equipos (zz
    id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    estado ENUM('nuevo', 'dañado') NOT NULL,
    descripcion TEXT,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

-- Borrar y crear tabla de reportes
DROP TABLE IF EXISTS reportes;
CREATE TABLE reportes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    equipo_id INT,
    descripcion_danios TEXT,
    fecha_registro DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (equipo_id) REFERENCES equipos(id)
);
