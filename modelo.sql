--1 creando modelo y base de datos
CREATE DATABASE prueba;
CREATE TABLE clientes (id SERIAL PRIMARY KEY, nombre VARCHAR(70),rut VARCHAR (20), direccion VARCHAR(100));
CREATE TABLE facturas (num_factura INT PRIMARY KEY,fecha_factura DATE,subtotal INT,iva INT,precio_total INT); 
CREATE TABLE productos(id SERIAL PRIMARY KEY, nombre VARCHAR(70) NOT NULL, descripcion VARCHAR(70),valor_unitario INT NOT NULL);
CREATE TABLE categorias(id SERIAL PRIMARY KEY, nombre VARCHAR(70) NOT NULL, descripcion VARCHAR(70));
CREATE TABLE facturas_clientes(cliente_id INT NOT NULL,factura_num INT NOT NULL UNIQUE, FOREIGN KEY (cliente_id) REFERENCES clientes(id), FOREIGN KEY (factura_num) REFERENCES facturas(num_factura));
CREATE TABLE lista_factura(id SERIAL PRIMARY KEY, producto_id INT NOT NULL,precio_unitario INT NOT NULL,cantidad INT NOT NULL,valor_total INT NOT NULL,factura_num INT NOT NULL,FOREIGN KEY(producto_id) REFERENCES productos(id), FOREIGN KEY (factura_num) REFERENCES facturas (num_factura));
CREATE TABLE productos_categorias(categoria_id INT NOT NULL,producto_id INT NOT NULL UNIQUE, FOREIGN KEY (categoria_id) REFERENCES categorias(id),  FOREIGN KEY (producto_id) REFERENCES productos(id));
--2 Poblando tablas
INSERT INTO productos(nombre,descripcion,valor_unitario) VALUES
('Quix','Detergente lavalosas',1000), ---1
('Omo','Detergente para ropa', 2500), --2
('Chef','Aceite',900), --3
('Lobos','Sal',2000), --4
('Iansa','Azucar',1300), --5
('Ariel','Detergente liquido ropa', 3000), --6
('Playstation 2','Consola',20000), --7
('Shadow of the colossus','Juego',5000); --8
INSERT INTO clientes (nombre,rut,direccion) VALUES
('Juan','11111111-1','los olmos 100'),
('Cristian','12222222-2','las lilas 200'),
('Dandi','13333333-3','las nieves 300'),
('Ariel','14444444-4','las lechugas 400'),
('Javiera','15555555-5','manuel quiroga 500');
INSERT INTO categorias (nombre,descripcion) VALUES
('Cocina', 'productos destinados a su uso en la cocina'),
('Entretenimiento', 'Tecnologia para entretener'),
('Aseo',' Para tener todo limpiecito');
INSERT INTO facturas(num_factura,fecha_factura,subtotal,iva,precio_total) VALUES
(10,'2020-09-04',1900,361,2261),
(20,'2020-09-04',6000,1140,7140),
(110,'2020-09-04',4200,798,4998),
(120,'2020-09-04',25000,4750,29750),
(130,'2020-09-04',6000,1140,7140),
(210,'2020-09-04',5000,950,5950),
(310,'2020-09-04',6900,1311,8211),
(320,'2020-09-04',5000,950,5950),
(330,'2020-09-04',6000,1140,7140),
(340,'2020-09-04',5000,950,5950);
INSERT INTO facturas_clientes(cliente_id,factura_num) VALUES
(1,10),
(1,20),
(2,110),
(2,120),
(2,130),
(3,210),
(4,310),
(4,320),
(4,330),
(4,340);
INSERT INTO lista_factura (producto_id,precio_unitario,cantidad,valor_total,factura_num)VALUES
(1,1000,1,1000,10),
(3,900,1,900,10),
(1,1000,1,1000,20),
(4,2000,1,2000,20),
(6,3000,1,3000,20),
(3,900,1,900,110),
(4,2000,1,2000,110),
(5,1300,1,1300,110),
(7,20000,1,20000,120),
(8,5000,1,5000,120),
(1,1000,1,1000,130),
(4,2000,1,2000,130),
(6,3000,1,3000,130),
(1,1000,5,5000,210),
(1,1000,1,1000,310),
(4,2000,1,2000,310),
(6,3000,1,3000,310),
(3,900,1,900,310),
(8,5000,1,5000,320),
(1,1000,1,1000,330),
(4,2000,1,2000,330),
(6,3000,1,3000,330),
(1,1000,3,3000,340),
(4,2000,1,2000,340);
INSERT INTO productos_categorias(categoria_id,producto_id) VALUES
(1,1),
(1,3),
(1,4),
(1,5),
(2,7),
(2,8),
(3,2),
(3,6);

--3 QUERIES
-- Cliente de la compra mas cara 
SELECT clientes.nombre,facturas.precio_total
FROM clientes INNER JOIN facturas_clientes ON facturas_clientes.cliente_id = clientes.id 
INNER JOIN facturas ON facturas_clientes.factura_num = facturas.num_factura 
ORDER BY facturas.precio_total DESC LIMIT (1);


SELECT clientes.nombre,facturas.precio_total
FROM clientes INNER JOIN facturas_clientes ON facturas_clientes.cliente_id = clientes.id 
INNER JOIN facturas ON facturas_clientes.factura_num = facturas.num_factura 
WHERE facturas.precio_total > 100;

SELECT COUNT(DISTINCT clientes.id)
FROM lista_factura JOIN facturas ON lista_factura.factura_num = facturas.num_factura
JOIN facturas_clientes ON facturas_clientes.factura_num = facturas.num_factura 
JOIN clientes ON facturas_clientes.cliente_id = clientes.id
WHERE producto_id = 6;



