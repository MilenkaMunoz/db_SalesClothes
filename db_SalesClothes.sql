
/* Crear base de datos Sales Clothes */
CREATE DATABASE db_SalesClothes;

/* Poner en uso la base de datos */
USE db_SalesClothes;

/* Poner en uso base de datos master */
USE master;

/* Eliminar base de datos */
DROP DATABASE db_SalesClothes;


/* Crear tabla client */
CREATE TABLE client
(
	id int, 
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	email varchar(80),
	cell_phone char(9),
	birthdate date,
	active bit
	CONSTRAINT client_pk PRIMARY KEY (id)
);


/* Ver estructura de tabla client */
EXEC sp_columns @table_name = 'client';

/* Listar tablas de la base de datos db_SalesClothes */
SELECT * FROM INFORMATION_SCHEMA.TABLES;

/* Eliminar tabla client */
DROP TABLE client;

/* Crear tabla sale */
CREATE TABLE sale
(
	id int, 
	date_time datetime,
	seller_id int,
	client_id int,
	active bit
	CONSTRAINT sale_pk PRIMARY KEY (id)
);

/* Crear tabla seller  */
CREATE TABLE seller
(
	id int, 
	type_document char(3),
	number_document char(15),
	names varchar(60),
	last_name varchar(90),
	salary decimal(8,2),
	cell_phone char(9),
	email varchar(80),
	active bit
	CONSTRAINT seller_pk PRIMARY KEY (id)
);

/* Crear tabla clothes */
CREATE TABLE clothes
(
	id int, 
	descriptions varchar (60),
	brand varchar(60),
	amount int,
	size varchar(10),
	price decimal(8,2),
	active bit
	CONSTRAINT clothes_pk PRIMARY KEY (id)
);

/* Crear tabla sale_detail */
CREATE TABLE sale_detail
(
	id int, 
	sale_id int,
	clothes_id int,
	amount int,
	CONSTRAINT sale_detail_pk PRIMARY KEY (id)
);


/* Relacionar tabla sale con tabla client */
ALTER TABLE sale
	ADD CONSTRAINT sale_client FOREIGN KEY (client_id)
	REFERENCES client (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO



/* Eliminar una relación */
ALTER TABLE sale
	DROP CONSTRAINT sale_client
GO

/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO



/* Relacionar tabla sale con tabla seller */
ALTER TABLE sale
	ADD CONSTRAINT sale_seller FOREIGN KEY (seller_id)
	REFERENCES seller (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO


/* Ver relaciones creadas entre las tablas de la base de datos */
SELECT 
    fk.name [Constraint],
    OBJECT_NAME(fk.parent_object_id) [Tabla],
    COL_NAME(fc.parent_object_id,fc.parent_column_id) [Columna FK],
    OBJECT_NAME (fk.referenced_object_id) AS [Tabla base],
    COL_NAME(fc.referenced_object_id, fc.referenced_column_id) AS [Columna PK]
FROM 
    sys.foreign_keys fk
    INNER JOIN sys.foreign_key_columns fc ON (fk.OBJECT_ID = fc.constraint_object_id)
GO

/* Relacionar tabla sale con tabla seller */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_clothes FOREIGN KEY (clothes_id)
	REFERENCES clothes (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO

/* Relacionar tabla sale con tabla seller */
ALTER TABLE sale_detail
	ADD CONSTRAINT sale_detail_sale FOREIGN KEY (sale_id)
	REFERENCES sale (id)
	ON UPDATE CASCADE 
      ON DELETE CASCADE
GO