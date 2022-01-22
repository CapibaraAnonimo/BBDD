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
	CONSTRAINT pk_lineaTicket PRIMARY KEY(comanda, producto)
);

ALTER TABLE categoria ADD CONSTRAINT fk_categoria FOREIGN KEY(categoria) REFERENCES categoria ON DELETE CASCADE;
ALTER TABLE lineaTicket ADD CONSTRAINT fk_ticket FOREIGN KEY(ticket) REFERENCES ticket ON DELETE CASCADE;
ALTER TABLE lineaDeComanda ADD CONSTRAINT fk_comanda FOREIGN KEY(comanda) REFERENCES comanda ON DELETE CASCADE;