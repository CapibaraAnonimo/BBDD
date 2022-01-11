CREATE TABLE libro (
	isbn			char(17),
	titulo			text,
	dni_autor		char(9),
	cod_genero		smallint,
	cod_editorial	smallint
)

CREATE TABLE autor (
	dni 			char(9),
	nombre			text,
	Nacionalidad	char(56)
)

CREATE TABLE editorial (
	cod_editorial	serial,
	nombre			text,
	direccion		text,
	poblacion		text
)

CREATE TABLE genero (
	id_genero	smallserial,
	nombre		text,
	descripcion	text
)

CREATE TABLE edicion (
	isbn				char(17),
	fecha_publicacion	date,
	cantidad			integer
)