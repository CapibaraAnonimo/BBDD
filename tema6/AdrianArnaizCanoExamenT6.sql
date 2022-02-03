CREATE TABLE empleado (
	num_empleado		serial,
	nombre				varchar(100) NOT null,
	apellidos			varchar(100) NOT null,
	email				varchar(100),
	cuenta_corriente	varchar(24),
	pass				varchar(8),
	CONSTRAINT pk_empleado PRIMARY KEY(num_empleado),
	CONSTRAINT ck_email CHECK(email ILIKE '%@%'),
	CONSTRAINT ck_24cuenta CHECK(LENGTH(cuenta_corriente) = 24),
	CONSTRAINT ck_EScuenta CHECK(cuenta_corriente LIKE 'ES%')
);

CREATE TABLE cliente (
	dni			varchar(10),
	nombre		varchar(100) NOT null,
	apellidos	varchar(100) NOT null,
	email		varchar(100),
	direccion	varchar(100),
	fecha_alta	date,
	CONSTRAINT pk_cliente PRIMARY KEY(dni),
	CONSTRAINT ck_email CHECK(email ILIKE '%@%')
);

CREATE TABLE linea_venta (
	id_venta	int,
	id_linea	serial,
	cantidad	smallint NOT null,
	producto	int NOT null,
	precio		real NOT null,
	CONSTRAINT pk_linea_venta PRIMARY KEY(id_venta, id_linea),
	CONSTRAINT ck_cantidadMas0 CHECK(cantidad > 0)
);

CREATE TABLE venta (
    ID_VENTA   SERIAL,
    FECHA      DATE NOT NULL,
    EMPLEADO   INTEGER NOT NULL,
    CLIENTE    VARCHAR(10),
    CONSTRAINT PK_VENTA PRIMARY KEY ( ID_VENTA )
);


CREATE TABLE producto (
    CUP           SERIAL,
    NOMBRE        VARCHAR(100) NOT NULL,
    DESCRIPCION   TEXT,
    PVP           NUMERIC(10,2) NOT NULL,
    CATEGORIA     INTEGER,
    CONSTRAINT PK_PRODUCTO PRIMARY KEY ( CUP )
);

CREATE TABLE categoria (
    ID_CATEGORIA   SERIAL,
    NOMBRE         VARCHAR(100) NOT NULL,
    DESCRIPCION    TEXT,
    CONSTRAINT PK_CATEGORIA PRIMARY KEY ( ID_CATEGORIA )
);

 INSERT INTO empleado VALUES (
    DEFAULT,
    'ANGEL',
    'NARANJO',
    'ANGEL.NARANJO@MITIENDA.ES',
    'ES1234567890123456789012',
    '12345'
);

INSERT INTO empleado VALUES (
    DEFAULT,
    'MIGUEL',
    'CAMPOS',
    'MIGUEL.CAMPOS@MITIENDA.ES',
    'ES9087564312213465780937',
    'USER1234'
);

INSERT INTO cliente VALUES (
    '12345678A',
    'JESÚS',
    'CASANOVA',
    'JESUS.CASANOVA@CORREO.COM',
    'C/ CONDES DE BUSTILLO S/N',
    CURRENT_DATE
);

INSERT INTO categoria VALUES (
    DEFAULT,
    'Macbook',
    'Todos los modelos de Macbook'
);

INSERT INTO categoria VALUES (
    DEFAULT,
    'Iphone',
    'Todos los modelos de Iphone'
);

INSERT INTO categoria VALUES (
    DEFAULT,
    'Apple Watch',
    'Todos los modelos de Apple Watch'
);


INSERT INTO producto VALUES (
    DEFAULT,
    'Macbook Pro 13" Chip M1 8/8 8GB 265GB',
    'Chip M1, con 8 núcleos de CPU y 8 de GPU, 8 GB de memoria unificada y 256 GB de almacenamiento SSD',
    1449.0,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Macbook')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'Macbook Pro 14" Chip M1 Pro 8/14 16GB/512GB',
    'Chip M1 Pro, con 8 núcleos de CPU, 14 de GPU, 16 GB de RAM y 512 GB de almacenamiento SSD',
    2249.0,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Macbook')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'Macbook Pro 16" Chip M1 Max 10/32 32GB/1TB',
    'Chip M1 Max, con 10 núcleos de CPU, 32 de GPU, 32 GB de RAM y 1TB de almacenamiento SSD',
    3849.0,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Macbook')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'iPhone Xs 5,8" 64GB',
    'Acabado en plata',
    1159,
    2
);

INSERT INTO producto VALUES (
    DEFAULT,
    'iPhone 13 Mini 5,4" 128GB',
    'Acabado medianoche',
    809.0,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Iphone')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'iPhone 13 Pro Max 6,7" 1TB',
    'Acabado en grafito',
    1839.0,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Iphone')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'Apple Watch Serie 7 41 mm',
    'Caja de aluminio verde y correa con eslabones de piel',
    479,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Apple Watch')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'Apple Watch SE 40mm',
    'Caja de aluminio en gris espacial - correa deportiva',
    299,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Apple Watch')
);

INSERT INTO producto VALUES (
    DEFAULT,
    'Apple Watch Nike 45mm',
    'Caja de aluminio en plata y correa Nike Sport platino puro/negra',
    459,
    (SELECT id_categoria FROM categoria WHERE nombre = 'Apple Watch')
);

INSERT INTO venta (fecha, empleado, cliente) VALUES (
	CURRENT_TIMESTAMP, 
	(SELECT num_empleado FROM empleado WHERE nombre ILIKE 'MIGUEL' AND apellidos ILIKE 'CAMPOS'), 
	(SELECT dni FROM cliente WHERE nombre ILIKE 'JESÚS' AND apellidos ILIKE 'CASANOVA')
);

INSERT INTO linea_venta (id_venta, cantidad, producto, precio) VALUES(
	1,
	1,
	2,
	2249.00
);

INSERT INTO cliente VALUES(
	'11111111A',
	'Rafael',
	'Villar',
	'villar@correo.com',
	'Calle Rue del Percebe 13',
	CURRENT_DATE
);

INSERT INTO venta (fecha, empleado, cliente) VALUES (
	CURRENT_TIMESTAMP, 
	(SELECT num_empleado FROM empleado WHERE nombre ILIKE 'ANGEL' AND apellidos ILIKE 'NARANJO'), 
	(SELECT dni FROM cliente WHERE nombre ILIKE 'Rafael' AND apellidos ILIKE 'Villar')
);

INSERT INTO linea_venta (id_venta, cantidad, producto, precio) VALUES(
	1,
	1,
	9,
	459.00
);




