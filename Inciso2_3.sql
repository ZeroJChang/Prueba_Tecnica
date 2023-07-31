CREATE DATABASE Examen
GO
USE Examen
GO
CREATE TABLE Restaurante
(
	IdRestaurante VARCHAR(8) PRIMARY KEY,
	Direccion VARCHAR(32) NOT NULL,
	Estado VARCHAR(4) NOT NULL
)
CREATE TABLE Producto
(
	CodigoProducto VARCHAR(8) PRIMARY KEY,
	Descripcion VARCHAR(16) NOT NULL,
	Estado VARCHAR(8) NOT NULL
)
Go
CREATE TABLE Orden
(
	IdOrden INT IDENTITY (1,1) PRIMARY KEY,
	IdRestaurante VARCHAR(8) NOT NULL,
	Cliente VARCHAR(64) NOT NULL,
	Fecha DATETIME NOT NULL,
	DireccionCliente VARCHAR(256) NOT NULL,
	CodigoProducto VARCHAR(8) NOT NULL,
	Cantidad INT NOT NULL,
	Precio NUMERIC(3,2) NOT NULL,
	Total NUMERIC(5,2) NOT NULL,
	EstadoOrden VARCHAR(8) NOT NULL,
	--Orden->Restaurante
	CONSTRAINT FK_O_R FOREIGN KEY (IdRestaurante) REFERENCES Restaurante(IdRestaurante)
	--Esta con el fin de poder llevar el correlativo de los pedidos en los restaurantes (2)
)
Go
CREATE TABLE DetalleOrden
(
	IdDetalleOrden INT IDENTITY (1,1) PRIMARY KEY,
	IdOrden int not null,
	CodigoProducto VARCHAR(8) NOT null,
	Cantidad INT not null,
	Precio decimal(3,2) not null,
	Total decimal (5,2) not null,
	--DetalleOrden->Orden
	Constraint FK_DO_O Foreign key (IdOrden) References Orden(IdOrden),
	--DetalleOrden->Producto
	Constraint FK_DO_P Foreign key (CodigoProducto) References Producto(CodigoProducto)
	--Estos para pedir mas de un producto por orden :) (1)
)

-- DEBIDO A QUE RESTAURANTE NO TIENE NOMBRE SE COLOCA su ID :)
GO
-- (3)
SELECT TOP 10 IdRestaurante, AVG(Total) AS Venta_Promedio FROM Orden WHERE Fecha >= DATEADD(MONTH, -1, GETDATE()) GROUP BY IdRestaurante
ORDER BY Venta_Promedio DESC;

GO
-- (4)
SELECT R.IdRestaurante, P.CodigoProducto, SUM(DO.Cantidad) AS Cantidad_Vendida FROM Restaurante R JOIN Orden O ON R.IdRestaurante = O.IdRestaurante JOIN DetalleOrden DO ON O.IdOrden = DO.IdOrden JOIN Producto P ON DO.CodigoProducto = P.CodigoProducto
GROUP BY R.IdRestaurante, P.CodigoProducto;

-- (5) no realizado (opcional)
GO
--Script llenado de Producto (CODIGO POR CHATGPT PARA AHORRAR TIEMPO)
-- Agregar algunos productos ficticios con sus respectivos estados
INSERT INTO Producto (CodigoProducto, Descripcion, Estado) VALUES
('P001', 'Hamburguesa', 'ALTA'),
('P002', 'Pizza Margarita', 'ALTA'),
('P003', 'Ensalada César', 'ALTA'),
('P004', 'Refresco Cola', 'ALTA'),
('P005', 'Cerveza Lager', 'ALTA'),
('P006', 'Sándwich Pollo', 'ALTA'),
('P007', 'Pasta Alfredo', 'ALTA'),
('P008', 'Tarta Manzana', 'ALTA'),
('P009', 'Café Espresso', 'ALTA'),
('P010', 'Té de Hierbas', 'ALTA'),
('P011', 'Sopa del Día', 'ALTA'),
('P012', 'Sushi Variado', 'ALTA'),
('P013', 'Pastel Choco', 'ALTA'),
('P014', 'Ensalada Frutas', 'ALTA'),
('P015', 'Jugo Naranja', 'ALTA'),
('P016', 'Café Leche', 'ALTA'),
('P017', 'Pollo Asado', 'ALTA'),
('P018', 'Churros Choco', 'ALTA'),
('P019', 'Helado Vainilla', 'ALTA'),
('P020', 'Mousse Frambue', 'ALTA');

-- Agregar algunos productos en estado de "BAJA"

INSERT INTO Producto (CodigoProducto, Descripcion, Estado) VALUES
('P021', 'Torta Queso', 'BAJA'),
('P022', 'Galletas Avena', 'BAJA'),
('P023', 'Puré Papas', 'BAJA');
-- Agregar algunos productos en estado de "CAMBIOS"

INSERT INTO Producto (CodigoProducto, Descripcion, Estado) VALUES
('P024', 'Parrillada Mixta', 'CAMBIOS'),
('P025', 'Tacos de Pescado', 'CAMBIOS'),
('P026', 'Batido de Fresa', 'CAMBIOS');


select * from Producto

UPDATE Producto
SET Estado = 'ALTA'
WHERE CodigoProducto = 'P001';