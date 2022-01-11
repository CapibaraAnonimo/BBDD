--No Seleccionar las 5 primeras lineas a no ser que ya hayas creado las siguientes tablas
DROP TABLE edicion;
DROP TABLE libro;
DROP TABLE autor;
DROP TABLE editorial;
DROP TABLE genero;

CREATE TABLE autor (
	dni 			char(9) PRIMARY KEY,
	nombre			text NOT NULL,
	Nacionalidad	char(56)
);

CREATE TABLE genero (
	id_genero	smallserial PRIMARY KEY,
	nombre		text NOT NULL,
	descripcion	text
);

CREATE TABLE editorial (
	cod_editorial	serial PRIMARY KEY,
	nombre			text NOT NULL,
	direccion		text,
	poblacion		text
);

CREATE TABLE libro (
	isbn			char(17) PRIMARY KEY,
	titulo			text NOT NULL,
	dni_autor		char(9) NOT NULL REFERENCES autor,
	cod_genero		smallint NOT NULL REFERENCES genero,
	cod_editorial	smallint NOT NULL REFERENCES editorial 
);

CREATE TABLE edicion (
	isbn				char(17) PRIMARY KEY REFERENCES libro,
	fecha_publicacion	date,
	cantidad			integer CHECK (cantidad > 0)
);