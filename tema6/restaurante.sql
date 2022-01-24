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

CREATE TABLE ticket (
	id_ticket	serial,
	reserva		int NOT null,
	precioTotal	real NOT null,
	CONSTRAINT pk_ticket PRIMARY KEY(id_ticket)
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
	id_reserva			serial,			
	mesa				int NOT NULL,
	fecha_reserva		timestamp NOT NULL,
	cliente				int,
CONSTRAINT pk_reserva PRIMARY KEY (id_reserva)
);

CREATE TABLE comanda (
	id_comanda			serial,
	reserva				int NOT NULL,
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


--Adrián
ALTER TABLE categoria ADD CONSTRAINT fk_categoria FOREIGN KEY(categoria) REFERENCES categoria ON DELETE CASCADE;
ALTER TABLE lineaTicket ADD CONSTRAINT fk_ticket FOREIGN KEY(ticket) REFERENCES ticket ON DELETE CASCADE;
ALTER TABLE lineaDeComanda ADD CONSTRAINT fk_comanda FOREIGN KEY(comanda) REFERENCES comanda ON DELETE CASCADE;
ALTER TABLE ticket ADD CONSTRAINT fk_ticket_reserva FOREIGN KEY(reserva) REFERENCES reserva ON DELETE CASCADE;
--Maylor
ALTER TABLE reserva ADD CONSTRAINT fk_reserva_cliente FOREIGN KEY (cliente) REFERENCES cliente ON DELETE NO ACTION; --en caso de poder hacer un analisis de a que hora se hace la mayoria
--de las reservas.
ALTER TABLE comanda ADD CONSTRAINT fk_comanda_reserva FOREIGN KEY (reserva) REFERENCES reserva ON DELETE CASCADE;
--Ana Pilar
ALTER TABLE mesa ADD CONSTRAINT fk_mesa_max_persona FOREIGN KEY (max_persona) REFERENCES reserva;
ALTER TABLE producto ADD CONSTRAINT fk_producto_categoria FOREIGN KEY (categoria) REFERENCES categoria;


--Introducción de los nombres de productos, categorías y precios
INSERT INTO producto 
VALUES ('Risotto de Torta del Casar', 13.50, 'Los Risottos de Burro'), ('Risotto Indonesio',13.50, 'Risotto de Boletus',12.90, 'Los Risottos de Burro'), 
	('Risotto Cremoso', 15.50, 'Los Risottos de Burro'), ('Risotto de Cordonices',13.50,'Los Risottos de Burro'), ('Risotto de trufa Negra',15.50,'Los Risottos de Burro'),
	('Risotto al nero',15.90,'Los Risottos de Burro'), ('Arroz de presa Ibérica',13.50,'Los Risottos de Burro'), ('Margherita Di Burrata',15.90,'De Nuestro Horno de Piedra'),
	('Formaggio exottica',13.50,'De Nuestro Horno de Piedra'),('Kabayaki Unagi',14.90,'De Nuestro Horno de Piedra'),('Umbra',13.50,'De Nuestro Horno de Piedra'),
	('Al Tartufo',15.50,'De Nuestro Horno de Piedra'), ('La Barbacoa Nikkei',14.50,'De Nuestro Horno de Piedra'), ('Arrabiata Carnívora',14.50,'De Nuestro Horno de Piedra'),
	('La Canard',15.90,'De Nuestro Horno de Piedra'), ('New Orleans',15.50,'De Nuestro Horno de Piedra'),('Taco de Salomillo',17.90,'Las Brasas De Burro'),('Chuleta 600g de lomo bajo',19.50,'Las Brasas De Burro'),
	('Tagliata de presa Ibérica',16.90,'Las Brasas De Burro'), ('Marget de presa Ibérica',13.90,'Las Brasas De Burro'),
	('Hamburguesa de Salomillo',14.50,'Las Brasas De Burro'), ('Coulant de chocolate',5.50,'Para Los Golosos, Todo Hecho En Casa'),('Panacotta de la casa',5.00,'Para Los Golosos, Todo Hecho En Casa'),
	('El Tiramisú casero',5.50,'Para Los Golosos, Todo Hecho En Casa'), ('Tarta de queso',6.00,'Para Los Golosos, Todo Hecho En Casa'),('Postre de torrija',6.00,'Para Los Golosos, Todo Hecho En Casa'),
	('Burro Amaretto',5.50,'Para Los Golosos, Todo Hecho En Casa'),('Canolo Siciliano',5.50,'Para Los Golosos, Todo Hecho En Casa'),('Tarta de zanahoria',6.00,'Para Los Golosos, Todo Hecho En Casa'),
	('La ensaladilla rusa',11.50,'Para Empezar'),('La César',12.50,'Para Empezar'),('Tagliata de atún',15.90,'Para Empezar'),('Ensalada de burrata trufada fresca',15.50,'Para Empezar'),('Burrata al tartufo',16.50,'Para Empezar'),
	('Carpaccio de presa Ibérica',13.50,'Para Empezar'),('La Hummus de Burro',9.90,'Para Empezar'),('Streak tartar',13.90,'Para Empezar'),('Alcachofas romanas salteadas',13.90,'Para Empezar'),
	('Ensalada templana Canard',14.90,'Para Empezar'),('El Vitello tonnato de Burro',14.90,'Para Empezar'),('La tabla de quesos de burro',14.90,'Para Empezar'),('Raviolis crujientes de secreto ibérico',13.90,'Para Empezar'),
	('Raviolis crujientes de rabo de toro',19.90,'Para Empezar'), ('Huevos rotos con bogavante',17.90,'Para Empezar'),('Huevos estrellados',10.90,'Para Empezar'),('Ensalada de queso armenio Shanklis',12.90,'Para Empezar'),
	('Spaghetti alla chitarra',20.90,'El Pastifigio'),('Tortelloni relleno de vieiras y langostinos',15.50,'El Pastifigio'),('Mar y montaña de Panzerottis',15.90,'El Pastifigio'),('Paccheri al nero di sepia',15.90,'El Pastifigio'),
	('Ravioli rellenos de pollo braseado',13.50,'El Pastifigio'),('Delizie rellenos',12.90,'El Pastifigio'),('Tortellini de foie e higos',15.90,'El Pastifigio'),('Raviolacci Wan ton',13.90,'El Pastifigio'),('Fattuccini Thom Kha Kai',14.90,'El Pastifigio'),
	('Tagliatelle a la carbonara',12.90,'El Pastifigio'),('Tagliolini saltado a la peruana',14,50,'El Pastifigio'),('Papardelle Japo',14.50,'El Pastifigio'),('Panzerotti rellenos',12.90,'El Pastifigio'),('Ravioli wan ton',12.90,'El Pastifigio'),
	('Lasaña artesana',14.90,'El Pastifigio'),('Canelones rellenos de pollo de corral y trufa',16.50,'El Pastifigio'),('Canelones rellenos de pato y foie al oporto',14.90,'El Pastifigio');


--Inserts de mesa
insert into mesa (id_mesa, max_persona) values (1, 2);
insert into mesa (id_mesa, max_persona) values (2, 8);
insert into mesa (id_mesa, max_persona) values (3, 2);
insert into mesa (id_mesa, max_persona) values (4, 8);
insert into mesa (id_mesa, max_persona) values (5, 6);
insert into mesa (id_mesa, max_persona) values (6, 3);
insert into mesa (id_mesa, max_persona) values (7, 5);
insert into mesa (id_mesa, max_persona) values (8, 6);
insert into mesa (id_mesa, max_persona) values (9, 6);
insert into mesa (id_mesa, max_persona) values (10, 2);
insert into mesa (id_mesa, max_persona) values (11, 7);
insert into mesa (id_mesa, max_persona) values (12, 7);
insert into mesa (id_mesa, max_persona) values (13, 8);
insert into mesa (id_mesa, max_persona) values (14, 7);
insert into mesa (id_mesa, max_persona) values (15, 4);


