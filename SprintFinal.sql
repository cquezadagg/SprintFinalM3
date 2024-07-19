-- Crear usuario y base de datos

Drop database if exists SprintFinal;
Create database SprintFinal;

Drop user if exists 'userFinal'@'localhost';
Create User 'userFinal'@'localhost' IDENTIFIED BY 'hola1234';
Grant Select,Create, Drop, Alter, Insert, Update, Delete, References on SprintFinal.* to 'userFinal'@'localhost';
Flush privileges;

-- Crear tablas necesarias
Use SprintFinal;

create table proveedores(
  id_proveedor int not null auto_increment,
  nombre_representante varchar(50) not null,
  nombre_corporativo varchar(50) not null,
  tel1 varchar(15) not null,
  nombre_contacto1 varchar(100) not null,
  tel2 varchar(15) not null,
  nombre_contacto2 varchar(100) not null,
  cat_prod enum('Electronicos','Verduras','Otros') not null,
  email varchar(50) not null,
  primary key(id_proveedor)
);

create table clientes(
  id_cliente int not null auto_increment,
  nombre varchar(50) not null,
  apellido varchar(50) not null,
  direccion varchar(50) not null unique,
  primary key(id_cliente)
);

create table productos(
  id_producto int not null auto_increment,
  nombre varchar(50) not null,
  categoria varchar(50) not null,
  precio numeric(10,2) not null,
  proveedor int not null,
  color varchar(15) not null,
  stock int not null,
  primary key(id_producto),
  foreign key(proveedor) references proveedores(id_proveedor)
);


-- Insertar de datos en las tablas

-- Insertar datos en la tabla proveedores
INSERT INTO proveedores (nombre_representante, nombre_corporativo, tel1, nombre_contacto1, tel2, nombre_contacto2, cat_prod, email) VALUES
('Juan Pérez', 'ElectroMarket', '555-1234', 'Ana López', '555-5678', 'Carlos Gómez', 'Electronicos', 'juan@electromarket.com'),
('Luis García', 'TechWorld', '555-2345', 'María Torres', '555-6789', 'José Ramírez', 'Electronicos', 'luis@techworld.com'),
('Carlos Hernández', 'GameZone', '555-3456', 'Elena Díaz', '555-7890', 'Laura Fernández', 'Otros', 'carlos@gamezone.com'),
('Marta Martínez', 'HomeGoods', '555-4567', 'Pedro Castillo', '555-8901', 'Sofía Cruz', 'Otros', 'marta@homegoods.com'),
('Patricia Sánchez', 'FreshFarm', '555-5678', 'Daniel Gómez', '555-9012', 'Lucía Navarro', 'Verduras', 'patricia@freshfarm.com');

-- Insertar datos en la tabla clientes
INSERT INTO clientes (nombre, apellido, direccion) VALUES
('Luis', 'Martínez', 'Av. Siempre Viva 123'),
('Ana', 'Gómez', 'Calle Falsa 456'),
('Pedro', 'Pérez', 'Boulevard Central 789'),
('María', 'López', 'Avenida Libertador 101'),
('José', 'Hernández', 'Plaza Mayor 202');

-- Insertar datos en la tabla productos
INSERT INTO productos (nombre, categoria, precio, proveedor, color, stock) VALUES
('Laptop', 'Electronicos', 850000.00, 1, 'Negro', 15),
('Televisor', 'Electronicos', 550000.00, 2, 'Negro', 20),
('Celular', 'Electronicos', 450000.00, 1, 'Blanco', 60),
('Impresora', 'Electronicos', 110000.00, 3, 'Gris', 10),
('Cámara', 'Electronicos', 300000.00, 2, 'Negro', 3),
('Monitor', 'Electronicos', 150000.00, 1, 'Negro', 25),
('Tablet', 'Electronicos', 225000.00, 3, 'Blanco', 30),
('Consola de Videojuegos', 'Videojuegos', 375000.00, 2, 'Negro', 12),
('Refrigerador', 'Otros', 750000.00, 4, 'Plata', 8),
('Microondas', 'Otros', 75000.00, 4, 'Blanco', 18),
('Laptop', 'Electronicos', 850000.00, 2, 'Negro', 15),
('Televisor', 'Electronicos', 550000.00, 3, 'Negro', 20),
('Celular', 'Electronicos', 450000.00, 4, 'Blanco', 50),
('Impresora', 'Electronicos', 110000.00, 1, 'Gris', 10),
('Cámara', 'Electronicos', 300000.00, 3, 'Negro', 5),
('Monitor', 'Electronicos', 150000.00, 2, 'Negro', 25),
('Tablet', 'Electronicos', 225000.00, 4, 'Blanco', 30),
('Consola de Videojuegos', 'Videojuegos', 375000.00, 1, 'Negro', 12),
('Refrigerador', 'Otros', 750000.00, 3, 'Plata', 8),
('Microondas', 'Otros', 75000.00, 2, 'Blanco', 18);


-- Querys solicitadas

-- Categoria producto que más se repite
SELECT 'Categoria de producto que más se repite';
SELECT categoria, COUNT(*) AS cantidad 
FROM productos 
GROUP BY categoria 
ORDER BY cantidad DESC 
LIMIT 1;

-- Producto con mayor Stock
SELECT 'Producto con mayor stock';
SELECT * 
FROM productos 
WHERE stock = (SELECT MAX(stock) FROM productos);

-- Color de producto más común
SELECT 'Color de producto más común';
SELECT color, COUNT(*) AS cantidad 
FROM productos 
GROUP BY color 
ORDER BY cantidad DESC 
LIMIT 1;

-- Proveedor con menor stock
SELECT 'Proveedor con menor stock';
SELECT * 
FROM productos 
WHERE stock = (SELECT MIN(stock) FROM productos);

-- Cambiar categoría del producto más popular por 'Electronica y computacion'
UPDATE productos 
SET categoria = 'Electronica y computacion' 
WHERE categoria = (
    SELECT categoria 
    FROM (
        SELECT categoria 
        FROM productos 
        GROUP BY categoria 
        ORDER BY COUNT(*) DESC 
        LIMIT 1
    ) AS subquery
);

SELECT 'Categoría actualizada para el producto con el mayor stock';

