DROP SCHEMA public CASCADE;
CREATE SCHEMA public;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO public;
COMMENT ON SCHEMA public IS 'standard public schema'; --Esto es solo par eliminar las tablas más rápido

--Adrián
CREATE TABLE categoria (
	id_categoria	serial,
	nombre			varchar NOT null,
	categoria		int,
	CONSTRAINT pk_categoria PRIMARY KEY(id_categoria)
);

CREATE TABLE lineaTicket (
	producto	int,
	cantidad	int NOT null,
	ticket		int,
	subTotal	real NOT null,
	CONSTRAINT pk_lineaTicket PRIMARY KEY(producto, ticket)
);

CREATE TABLE lineaDeComanda (
	comanda		int,
	producto	int,
	cantidad	int NOT null,
	CONSTRAINT pk_lineaDeComanda PRIMARY KEY(comanda, producto)
);

--Maylor
CREATE TABLE cliente (
	id_cliente			serial NOT NULL,
	nombre				varchar (100) NOT NULL,
	apellidos			varchar (260) NOT NULL,
	telefono			varchar (14) NOT NULL,
CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
);

CREATE TABLE reserva (
	id_reserva			serial NOT NULL,			
	mesa				int NOT NULL,
	fecha_reserva		timestamp NOT NULL,
	cliente				serial,
CONSTRAINT pk_reserva PRIMARY KEY (id_reserva)
);

CREATE TABLE comanda (
	id_comanda			int NOT NULL,
	reserva				serial NOT NULL,
CONSTRAINT pk_comanda PRIMARY KEY (id_comanda)
);

--Ana Pilar
CREATE TABLE mesa (

	id_mesa		serial,
	max_persona	int NOT  NULL,
	CONSTRAINT pk_mesa PRIMARY KEY (id_mesa)

);

CREATE TABLE producto(

	id_producto	serial,
	nombre		varchar(100) NOT NULL,
	precio		numeric NOT NULL,
	categoria	varchar(100) NOT NULL,
	CONSTRAINT pk_producto PRIMARY KEY (id_producto)

);

CREATE TABLE linea_ticket(

	producto	varchar(100),
	cantidad	int,
	ticket		numeric,
	sub_total	numeric,
	CONSTRAINT pk_linea_ticket PRIMARY KEY (sub_total)

);

--Adrián
ALTER TABLE categoria ADD CONSTRAINT fk_categoria FOREIGN KEY(categoria) REFERENCES categoria ON DELETE CASCADE;
ALTER TABLE lineaTicket ADD CONSTRAINT fk_ticket FOREIGN KEY(ticket) REFERENCES ticket ON DELETE CASCADE;
ALTER TABLE lineaDeComanda ADD CONSTRAINT fk_comanda FOREIGN KEY(comanda) REFERENCES comanda ON DELETE CASCADE;
--Maylor
ALTER TABLE reserva ADD CONSTRAINT fk_reserva_cliente FOREIGN KEY (cliente) REFERENCES cliente ON DELETE NO ACTION; --en caso de poder hacer un analisis de a que hora se hace la mayoria
--de las reservas.
ALTER TABLE comanda ADD CONSTRAINT fk_comanda_reserva FOREIGN KEY (reserva) REFERENCES reserva ON DELETE CASCADE;
ALTER TABLE ticket ADD CONSTRAINT fk_ticket_reserva FOREIGN KEY (reserva) REFERENCES reserva ON DELETE CASCADE;
--Ana Pilar
ALTER TABLE mesa ADD CONSTRAINT fk_mesa_max_persona FOREIGN KEY (max_persona) REFERENCES reserva;
ALTER TABLE producto ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria) REFERENCES categoria;
ALTER TABLE linea_ticket ADD CONSTRAINT fk_linea_ticket_ticket FOREIGN KEY (ticket) REFERENCES ticket;