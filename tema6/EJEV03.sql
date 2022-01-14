DROP TABLE empresas;
DROP TABLE alumnos;
DROP TABLE profesores;
DROP TABLE tipos_cursos;
DROP TABLE alumnos_asisten;
DROP TABLE cursos;

CREATE TABLE empresas (
	cif			char(10),
	nombe		char,
	direccion	text,
	telefono	char(10),
	CONSTRAINT pk_empresa PRIMARY KEY(cif)
);

CREATE TABLE alumnos (
	dni			char(10),
	nombre		char,
	direccion	text,
	telefono	char(10),
	edad		smallint,
	empresa	char(10),
	CONSTRAINT pk_alumno PRIMARY KEY(dni),
	CONSTRAINT fk_empresa FOREIGN KEY(empresa) REFERENCES empresas ON DELETE NO ACTION
);

CREATE TABLE profesores(
	dni			char(10),
	nombre		char,
	apellido	char,
	telefono	char(10),
	direccion	text,
	CONSTRAINT pk_profesor PRIMARY KEY(dni)
);

CREATE TABLE tipos_curso(
	cod_curso	smallserial,
	duracion	int,
	programa	text,
	titulo		char,
	CONSTRAINT pk_tipo_curso PRIMARY KEY(cod_curso)
);

CREATE TABLE cursos(
	n_concreto		smallserial,
	fecha_inicio	date,
	fecha_fin		date,
	dni_profesor	char(10),
	tipo_curso		smallint,
	CONSTRAINT pk_curso PRIMARY KEY(n_concreto),
	CONSTRAINT fk_profesor	FOREIGN KEY(dni_profesor) REFERENCES profesores,
	CONSTRAINT fk_tipo_curso FOREIGN KEY(tipo_curso) REFERENCES tipos_curso
);

CREATE TABLE alumnos_asisten(
	dni			char(10),
	n_concreto	smallint,
	CONSTRAINT pk_alumno_asiste PRIMARY KEY(dni,n_concreto),
	CONSTRAINT fk_alumno FOREIGN KEY(dni) REFERENCES alumnos,
	CONSTRAINT fk_curso FOREIGN KEY(n_concreto) REFERENCES cursos
);








