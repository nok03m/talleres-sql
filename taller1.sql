CREATE DATABASE IF NOT EXISTS techstore;
USE techstore;

CREATE TABLE productos (
  id_producto INT PRIMARY KEY AUTO_INCREMENT,
  nombre      VARCHAR(150) NOT NULL,
  categoria   VARCHAR(60) NOT NULL,
  precio      DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
  stock       INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY AUTO_INCREMENT,
  nombre     VARCHAR(100) NOT NULL,
  email      VARCHAR(150) UNIQUE,
  ciudad     VARCHAR(60) NOT NULL,
  telefono   VARCHAR(30)
);

CREATE TABLE ventas (
  id_venta    INT PRIMARY KEY AUTO_INCREMENT,
  id_cliente  INT NOT NULL,
  id_producto INT NOT NULL,
  cantidad    INT NOT NULL CHECK (cantidad > 0),
  fecha_venta DATE NOT NULL,
  FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
  FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

ALTER TABLE clientes
  MODIFY COLUMN telefono VARCHAR(30);

ALTER TABLE productos
  MODIFY COLUMN nombre VARCHAR(150);

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Mouse Inalambrico Smart',  'Perifericos',     35.00,  50),
('Teclado Mecanico RGB',     'Perifericos',     89.90,  30),
('Monitor 24 Full HD',       'Monitores',       210.00, 20),
('Monitor 27 Smart Curvo',   'Monitores',       320.00, 15),
('Portatil UltraSlim 14',    'Computadores',    1200.00,10),
('PC Escritorio Gamer',      'Computadores',    1500.00, 8),
('Disco SSD 1TB',            'Almacenamiento',  95.00,  40),
('Memoria USB 64GB',         'Almacenamiento',  12.50, 100),
('Placa Madre Smart Board',  'Componentes',     180.00, 12),
('Audifonos Smart Bass',     'Audio',           60.00,  25),
('Parlante Bluetooth',       'Audio',           45.00,  35),
('Mochila para Portatil',    'Accesorios',      30.00,  60);

INSERT INTO clientes (nombre, email, ciudad, telefono) VALUES
('Maria Fernanda Ruiz', 'maria.ruiz@mail.com',   'Cucuta',      '3101112233'),
('Carlos Hernandez',    'carlos.hdez@mail.com',  'Bogota',      '3102223344'),
('Lucia Gomez',         'lucia.gomez@mail.com',  'Medellin',    '3103334455'),
('Andres Vargas',       'andres.vargas@mail.com','Cali',        '3104445566'),
('Paula Rojas',         'paula.rojas@mail.com',  'Bucaramanga', '3105556677'),
('Diego Suarez',        'diego.suarez@mail.com', 'Bucaramanga', '3106667788');

INSERT INTO ventas (id_cliente, id_producto, cantidad, fecha_venta) VALUES
(1, 1, 2, '2026-01-05'),
(2, 3, 1, '2026-01-07'),
(3, 5, 1, '2026-01-10'),
(4, 7, 3, '2026-01-12'),
(5, 10, 2, '2026-01-15'),
(1, 2, 1, '2026-01-18'),
(6, 4, 1, '2026-01-20'),
(2, 8, 5, '2026-01-22'),
(3, 6, 1, '2026-01-25'),
(1, 1, 1, '2026-02-01'),
(4, 9, 1, '2026-02-03'),
(5, 11, 2, '2026-02-05');

UPDATE productos
SET precio = 39.90
WHERE nombre = 'Mouse Inalambrico Smart';

UPDATE productos
SET stock = stock - 2
WHERE nombre = 'Mouse Inalambrico Smart';

INSERT INTO productos (nombre, categoria, precio, stock) VALUES
('Producto Erroneo de Prueba', 'Accesorios', 1.00, 1);

DELETE FROM productos
WHERE nombre = 'Producto Erroneo de Prueba';

SELECT *
FROM productos;

SELECT nombre, precio
FROM productos;

SELECT nombre, precio AS precio_venta
FROM productos;

SELECT nombre, precio, categoria
FROM productos
WHERE precio > 100;

SELECT nombre, email, ciudad
FROM clientes
WHERE ciudad = 'Bucaramanga';

SELECT nombre, precio, categoria
FROM productos
WHERE categoria = 'Perifericos';

SELECT nombre, precio, categoria
FROM productos
WHERE categoria = 'Perifericos'
  AND precio < 50;

SELECT nombre, email, ciudad
FROM clientes
WHERE ciudad = 'Bogota' OR ciudad = 'Medellin';

SELECT nombre, precio, categoria
FROM productos
WHERE precio BETWEEN 50 AND 300;

SELECT nombre, precio, categoria
FROM productos
WHERE categoria IN ('Monitores', 'Audio');

SELECT nombre, precio, categoria
FROM productos
WHERE nombre LIKE '%Smart%';

SELECT nombre, precio
FROM productos
ORDER BY precio ASC;

SELECT nombre, stock, precio
FROM productos
WHERE precio > 30
ORDER BY stock DESC;
