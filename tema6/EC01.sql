--No Seleccionar las 5 primeras lineas a no ser que ya hayas creado las siguientes tablas
DROP TABLE edicion;
DROP TABLE libro;
DROP TABLE autor;
DROP TABLE editorial;
DROP TABLE genero;

CREATE TABLE autor (
	dni 			varchar(9),
	nombre			text NOT NULL,
	Nacionalidad	varchar(56),
	CONSTRAINT pk_autor PRIMARY KEY (dni)
);

CREATE TABLE genero (
	id_genero	smallserial,
	nombre		text NOT NULL,
	descripcion	text,
	CONSTRAINT pk_genero PRIMARY KEY (id_genero)
);

CREATE TABLE editorial (
	cod_editorial	serial,
	nombre			text NOT NULL,
	direccion		text,
	poblacion		text,
	CONSTRAINT pk_editorial PRIMARY KEY (cod_editorial)
);

CREATE TABLE libro (
	isbn			varchar(17),
	titulo			text NOT NULL,
	dni_autor		char(9) NOT NULL,
	cod_genero		smallint NOT NULL,
	cod_editorial	smallint NOT NULL,
	CONSTRAINT pk_libro PRIMARY KEY (isbn),
	CONSTRAINT fk_autor FOREIGN KEY (dni_autor) REFERENCES autor ON DELETE RESTRICT,
	CONSTRAINT fk_genero FOREIGN KEY (cod_genero) REFERENCES genero ON DELETE RESTRICT,
	CONSTRAINT fk_editorial FOREIGN KEY (cod_editorial) REFERENCES editorial ON DELETE NO ACTION 
);

ALTER TABLE libro DROP CONSTRAINT fk_autor;
ALTER TABLE libro ADD CONSTRAINT fk_autor FOREIGN KEY (dni_autor) REFERENCES autor ON DELETE RESTRICT;

ALTER TABLE libro DROP CONSTRAINT fk_genero;
ALTER TABLE libro ADD CONSTRAINT fk_genero FOREIGN KEY (cod_genero) REFERENCES genero ON DELETE RESTRICT;

ALTER TABLE libro DROP CONSTRAINT fk_editorial;
ALTER TABLE libro ADD CONSTRAINT fk_editorial FOREIGN KEY (cod_editorial) REFERENCES editorial ON DELETE NO ACTION;

CREATE TABLE edicion (
	isbn				char(17),
	fecha_publicacion	date,
	cantidad			integer,
	CONSTRAINT pk_edicion PRIMARY KEY (isbn),
	CONSTRAINT fk_libro FOREIGN KEY (isbn) REFERENCES libro ON DELETE RESTRICT,
	CONSTRAINT cantidad_versiones CHECK (cantidad > 0)
);

ALTER TABLE edicion DROP CONSTRAINT fk_libro;
ALTER TABLE edicion ADD CONSTRAINT fk_libro FOREIGN KEY (isbn) REFERENCES libro ON DELETE RESTRICT;