CREATE DATABASE IF NOT EXISTS electrohogar;
USE electrohogar;

CREATE TABLE categorias (
  id_categoria INT PRIMARY KEY AUTO_INCREMENT,
  nombre       VARCHAR(80) NOT NULL,
  descripcion  VARCHAR(255)
);

CREATE TABLE departamentos (
  id_departamento INT PRIMARY KEY AUTO_INCREMENT,
  nombre          VARCHAR(80) NOT NULL
);

CREATE TABLE productos (
  id_producto    INT PRIMARY KEY AUTO_INCREMENT,
  nombre         VARCHAR(100) NOT NULL UNIQUE,
  precio         DECIMAL(10,2) NOT NULL,
  stock          INT NOT NULL CHECK (stock >= 0),
  id_categoria   INT,
  fecha_registro DATE DEFAULT (CURRENT_DATE),
  FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE empleados (
  id_empleado         INT PRIMARY KEY AUTO_INCREMENT,
  nombre              VARCHAR(100) NOT NULL,
  email               VARCHAR(150) UNIQUE,
  salario             DECIMAL(10,2) CHECK (salario >= 0),
  id_departamento     INT,
  fecha_contratacion  DATE DEFAULT (CURRENT_DATE),
  FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

CREATE TABLE clientes (
  id_cliente          INT PRIMARY KEY AUTO_INCREMENT,
  nombre              VARCHAR(100) NOT NULL,
  email               VARCHAR(150),
  ciudad              VARCHAR(60),
  fecha_registro      DATE DEFAULT (CURRENT_DATE),
  acepta_promociones  BOOLEAN
);

CREATE TABLE ventas (
  id_venta     INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente   INT,
  id_empleado  INT,
  fecha        DATE NOT NULL,
  total        DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
);

CREATE TABLE detalle_ventas (
  id_detalle      INT PRIMARY KEY AUTO_INCREMENT,
  id_venta        INT,
  id_producto     INT,
  cantidad        INT NOT NULL CHECK (cantidad > 0),
  precio_unitario DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

INSERT INTO categorias (nombre, descripcion) VALUES
('Electrodomesticos', 'Linea blanca y pequenos electrodomesticos'),
('Tecnologia', 'Computadores, celulares y accesorios'),
('Hogar', 'Articulos para el hogar');

INSERT INTO departamentos (nombre) VALUES
('Ventas'),
('Compras'),
('Recursos Humanos'),
('Contabilidad'),
('Sistemas'),
('E-commerce');

ALTER TABLE empleados
  ADD COLUMN correo_corporativo VARCHAR(150);

INSERT INTO empleados (nombre, email, salario, id_departamento, correo_corporativo) VALUES
('Laura Gomez',   'laura.gomez@mail.com',   1800000, 1, 'laura.gomez@electrohogar.com'),
('Carlos Ruiz',   'carlos.ruiz@mail.com',   2000000, 1, 'carlos.ruiz@electrohogar.com'),
('Marta Diaz',    'marta.diaz@mail.com',    2200000, 2, 'marta.diaz@electrohogar.com'),
('Andres Torres', 'andres.torres@mail.com', 1900000, 3, 'andres.torres@electrohogar.com'),
('Diana Perez',   'diana.perez@mail.com',   2100000, 5, 'diana.perez@electrohogar.com');

INSERT INTO clientes (nombre, email, ciudad, acepta_promociones) VALUES
('Juan Perez',    'juan.perez@mail.com',    'Bogota',      TRUE),
('Ana Martinez',  'ana.martinez@mail.com',  'Bogota',      TRUE),
('Pedro Lopez',   'pedro.lopez@mail.com',   'Bogota',      FALSE),
('Sofia Ramirez', 'sofia.ramirez@mail.com', 'Medellin',    TRUE),
('Luis Castro',   'luis.castro@mail.com',   'Cali',        FALSE),
('Camila Ortiz',  'camila.ortiz@mail.com',  'Bucaramanga', TRUE),
('Jorge Salas',   'jorge.salas@mail.com',   'Bogota',      TRUE);

INSERT INTO productos (nombre, precio, stock, id_categoria) VALUES
('Refrigerador Inverter 400L',   1899.90,  15, 1),
('Lavadora Carga Frontal 18kg',  1299.50,  10, 1),
('Smart TV 55 pulgadas',          950.00,   8, 2),
('Celular Smart X200',            699.00,  20, 2),
('Laptop UltraSlim 14',          1200.00,   5, 2),
('Licuadora Pro 900W',            120.00,  30, 1),
('Aspiradora Robot Smart',        450.00,  12, 3),
('Horno Microondas 25L',          180.00,  25, 1);

DROP TABLE IF EXISTS productos_prueba;

ALTER TABLE clientes
  ADD COLUMN telefono VARCHAR(20);

INSERT INTO productos (id_producto, nombre, precio, stock, id_categoria) VALUES
(118, 'Producto Descontinuado', 45.90, 3, 1),
(310, 'Producto Error Precio', 45.90, 5, 1);

INSERT INTO productos
  (nombre, precio, stock, id_categoria)
VALUES
  ('Refrigerador Inverter 500L', 2199.90, 15, 1);

UPDATE productos
SET stock = stock - 1
WHERE id_producto = (SELECT id_producto FROM (SELECT id_producto FROM productos WHERE nombre = 'Celular Smart X200') AS t);

UPDATE productos
SET precio = 549.00
WHERE id_producto = 310;

DELETE FROM productos
WHERE id_producto = 118;

INSERT INTO ventas (id_cliente, id_empleado, fecha, total) VALUES
(1, 1, '2026-01-05', 950.00),
(2, 1, '2026-01-10', 1200.00),
(3, 2, '2026-01-15', 699.00),
(4, 2, '2026-01-20', 1899.90),
(1, 1, '2026-01-25', 120.00),
(5, 3, '2026-02-02', 450.00),
(6, 1, '2026-02-05', 699.00),
(7, 2, '2026-02-08', 1299.50),
(2, 1, '2026-02-12', 180.00),
(3, 3, '2026-02-15', 950.00),
(4, 1, '2026-02-18', 699.00),
(1, 2, '2026-02-20', 1200.00);

INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario) VALUES
(1, 3, 1, 950.00),
(2, 5, 1, 1200.00),
(3, 4, 1, 699.00),
(4, 1, 1, 1899.90),
(5, 6, 1, 120.00),
(6, 7, 1, 450.00),
(7, 4, 1, 699.00),
(8, 2, 1, 1299.50),
(9, 8, 1, 180.00),
(10, 3, 1, 950.00),
(11, 4, 1, 699.00),
(12, 5, 1, 1200.00);

SELECT nombre, stock, precio
FROM productos
WHERE stock < 10
ORDER BY stock ASC;

SELECT nombre, fecha_registro
FROM clientes
WHERE ciudad = 'Bogota'
ORDER BY fecha_registro DESC
LIMIT 5;

SELECT id_venta, fecha, total
FROM ventas
WHERE total > 500
  AND fecha BETWEEN '2026-01-01' AND '2026-01-31'
ORDER BY fecha;

SELECT p.nombre, p.precio, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE c.nombre IN ('Electrodomesticos', 'Tecnologia')
  AND p.nombre LIKE '%Smart%';

SELECT
  id_empleado,
  COUNT(*)   AS num_ventas,
  SUM(total) AS total_vendido
FROM ventas
GROUP BY id_empleado
ORDER BY total_vendido DESC;

SELECT
  id_categoria,
  AVG(precio) AS precio_promedio
FROM productos
GROUP BY id_categoria
HAVING AVG(precio) > 300000;