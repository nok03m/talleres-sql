-- Creación e inicialización de la base de datos
CREATE DATABASE IF NOT EXISTS taller_tienda;
USE taller_tienda;

-- Limpieza de esquema en el orden correcto (Vistas -> Tablas hijas -> Tablas padres)
DROP VIEW IF EXISTS vista_productos_caros;
DROP TABLE IF EXISTS ventas;
DROP TABLE IF EXISTS productos;

-- 1. Tabla productos (con convenciones snake_case, NOT NULL y CHECK)
CREATE TABLE productos (
id_producto INT PRIMARY KEY AUTO_INCREMENT,
nombre      VARCHAR(100) NOT NULL,
precio      DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
categoria   VARCHAR(50) NOT NULL
);

-- 2. Tabla ventas (con llave autoincremental y restricciones de cantidad)
CREATE TABLE ventas (
id_venta    INT PRIMARY KEY AUTO_INCREMENT,
id_producto INT NOT NULL,
cantidad    INT NOT NULL CHECK (cantidad > 0),
fecha       DATE NOT NULL,
FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- Inserción de datos (se omite el ID explícito gracias al AUTO_INCREMENT)
INSERT INTO productos (nombre, precio, categoria) VALUES
('Televisor LED 50 pulgadas',       1850000.00, 'Electrodomesticos'),
('Licuadora Oster',                   145000.00, 'Electrodomesticos'),
('Camiseta deportiva Nike',            89000.00, 'Ropa'),
('Jean clasico Levis',                159000.00, 'Ropa'),
('Zapatillas running Adidas',         320000.00, 'Calzado'),
('Sandalias de playa',                 45000.00, 'Calzado'),
('Portatil HP 15 pulgadas',          2350000.00, 'Tecnologia'),
('Mouse inalambrico Logitech',         65000.00, 'Tecnologia'),
('Audifonos Bluetooth JBL',           189000.00, 'Tecnologia'),
('Cafetera electrica',               120000.00, 'Electrodomesticos'),
('Silla de oficina ergonomica',       480000.00, 'Hogar'),
('Lampara de escritorio LED',          38000.00, 'Hogar'),
('Mochila para portatil',              95000.00, 'Accesorios'),
('Reloj inteligente Xiaomi',          210000.00, 'Tecnologia'),
('Set de ollas antiadherentes',       310000.00, 'Hogar');

INSERT INTO ventas (id_producto, cantidad, fecha) VALUES
(1,  1, '2026-01-15'),
(2,  4, '2026-01-18'),
(3,  6, '2026-02-02'),
(4,  2, '2026-02-10'),
(5,  3, '2026-02-14'),
(6,  8, '2026-03-01'),
(7,  1, '2026-03-05'),
(8,  5, '2026-03-09'),
(9,  2, '2026-03-20'),
(10, 4, '2026-04-01'),
(11, 1, '2026-04-08'),
(12, 7, '2026-04-15'),
(13, 3, '2026-05-02'),
(14, 2, '2026-05-10'),
(15, 1, '2026-05-18'),
(3,  2, '2026-05-22'),
(8,  6, '2026-06-01'),
(5,  1, '2026-06-05'),
(9,  4, '2026-06-12'),
(2,  1, '2026-06-19');

-- 4. Reemplazo de tabla física estática por una VISTA dinámica (VIEW)
CREATE VIEW vista_productos_caros AS
SELECT nombre, precio
FROM productos
WHERE precio > 100000;

-- Demostración de la vista
SELECT * FROM vista_productos_caros;

-- 5. Alias de tabla combinando productos y ventas
SELECT p.nombre, v.cantidad, v.fecha
FROM productos p
JOIN ventas v ON p.id_producto = v.id_producto;

-- 6. Al menos 3 funciones sobre campos
SELECT UPPER(p.categoria) AS categoria_mayus,
ROUND(p.precio, 0) AS precio_redondeado,
CONCAT(p.nombre, ' - ', p.categoria) AS detalle
FROM productos p;

-- 7. Clasificar productos con IF
SELECT nombre, precio,
IF(precio > 100000, 'Premium', 'Estandar') AS categoria_precio
FROM productos;

-- 8. Consulta final integradora: cálculo completo y correcto del total
SELECT p.nombre AS producto,
UPPER(p.categoria) AS categoria,
v.cantidad,
p.precio AS precio_unitario_base,
IF(v.cantidad > 3, p.precio * 0.9, p.precio) AS precio_unitario_final,
IF(v.cantidad > 3, (p.precio * 0.9) * v.cantidad, p.precio * v.cantidad) AS total_venta
FROM productos p
JOIN ventas v ON p.id_producto = v.id_producto;

-- Consulta final de productos
SELECT * FROM productos;