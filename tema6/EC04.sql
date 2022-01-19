DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
COMMENT ON SCHEMA public IS 'standard public schema'; --Esto es solo par eliminar las tablas más rápido

CREATE TABLE invitados (
	nroInvitados	serial,
	nombre			varchar NOT null,
	categoria		varchar NOT null,
	origen			varchar NOT null,
	CONSTRAINT pk_invitados PRIMARY KEY(nroInvitados)
);

CREATE TABLE teatros (
	codTeat			serial,
	nombre			varchar NOT null,
	direccion		varchar NOT null,
	cantAsientos	int NOT null,
	CONSTRAINT pk_teatros PRIMARY KEY(codTeat)
);

CREATE TABLE obras (
	codObra		serial,
	nombreObra	varchar NOT null,
	autor		varchar,
	CONSTRAINT pk_obras PRIMARY KEY(codObra)
);

CREATE TABLE exhibe (
	codTeat		int,
	fecha		timeStamp,
	codObra		int,
	CONSTRAINT pk_exhibe PRIMARY KEY(codTeat, fecha)
);

CREATE TABLE tipos_asientos(
	tipo		int,
	nombre		varchar NOT null,
	descripcion	varchar,
	CONSTRAINT pk_tipos_asientos PRIMARY KEY(tipo)
);

CREATE TABLE asiento_tipos(
	nroAsiento	serial,
	tipo		int NOT null,
	CONSTRAINT pk_asiento_tipos PRIMARY KEY(tipo)
);

CREATE TABLE precio (
	codTeat serial,
	fecha	timestamp,
	tipo	int,
	precio	int NOT null,
	CONSTRAINT pk_precio PRIMARY KEY(codTeat, fecha, tipo)
);

CREATE TABLE entradas (
	codTeat		int,
	fecha		timestamp,
	nroAsiento	int,
	nroInvit	int,
	CONSTRAINT pk_entradas PRIMARY KEY(codTeat, fecha, NroAsiento)
);

ALTER TABLE exhibe ADD CONSTRAINT fk_teatros FOREIGN KEY(codTeat) REFERENCES teatros;
ALTER TABLE exhibe ADD CONSTRAINT fk_obras FOREIGN KEY(codObra) REFERENCES obras;
ALTER TABLE asiento_tipos ADD CONSTRAINT fk_tipos_asientos FOREIGN KEY(tipo) REFERENCES tipos_asientos;
ALTER TABLE precio ADD CONSTRAINT fk_exhibe_precio FOREIGN KEY(codTeat, fecha) REFERENCES exhibe;
ALTER TABLE precio ADD CONSTRAINT fk_tipos_asientos FOREIGN KEY(tipo) REFERENCES tipos_asientos;
ALTER TABLE entradas ADD CONSTRAINT fk_exhibe_entradas FOREIGN KEY(codTeat, fecha) REFERENCES exhibe;
ALTER TABLE entradas ADD CONSTRAINT fk_asiento_tipos FOREIGN KEY(nroAsiento) REFERENCES asiento_tipos;
ALTER TABLE entradas ADD CONSTRAINT fk_invitados FOREIGN KEY(nroInvit) REFERENCES invitados;


INSERT INTO invitados (nombre, categoria, origen) VALUES
('nombre1', 'prensa', 'España'),
('nombre2', 'prensa', 'España'),
('nombre3', 'crítica', 'Portugal');

INSERT INTO teatros (nombre, direccion, cantAsientos) VALUES
('Teatro1', 'Calle 1', 214),
('Teatro2', 'Calle 2', 561),
('Teatro3', 'Calle 3', 107);

SELECT *
FROM teatros;