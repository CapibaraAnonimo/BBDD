DROP TABLE IF EXISTS uso;
DROP TABLE IF EXISTS usuarios;
DROP TABLE IF EXISTS estaciones;
DROP TABLE IF EXISTS bicicletas;

CREATE TABLE usuarios (
	dni					varchar(10),
	nombre				varchar NOT NULL,
	apellidos			varchar NOT NULL,
	direccion			varchar,
	telefono			varchar(10) NOT NULL,
	email				varchar(320) NOT NULL,
	passw				varchar(8) NOT NULL,
	saldo_disponible	int DEFAULT 0,
	CONSTRAINT pk_usuarios PRIMARY KEY(dni),
	CONSTRAINT ck_pasword_length CHECK(LENGTH(passw) > 3)
);

CREATE TABLE estaciones (
	cod_estacion	varchar(10),
	num_estacion	serial NOT NULL,
	direccion		varchar NOT NULL,
	latitud			int NOT NULL,
	longitud		int NOT NULL,
	CONSTRAINT pk_estaciones PRIMARY KEY(cod_estacion),
	CONSTRAINT ck_starts_e CHECK(cod_estacion ILIKE 'e%')
);

CREATE TABLE bicicletas (
	cod_bicicleta	serial,
	marca			varchar NOT NULL,
	modelo			varchar NOT NULL,
	fecha_alta		date NOT NULL,
	CONSTRAINT pk_bicicletas PRIMARY KEY(cod_bicicleta)
);

CREATE TABLE uso (
	estacion_salida		varchar,
	fecha_salida		timestamp,
	dni_usuarios		varchar(10),
	cod_bicicleta		int,
	estacion_llegada	varchar,
	fecha_llegada		timestamp NOT NULL,
	CONSTRAINT pk_uso PRIMARY KEY(estacion_salida, fecha_salida, dni_usuarios, cod_bicicleta, estacion_llegada)
);

ALTER TABLE uso ADD FOREIGN KEY(estacion_salida) REFERENCES estaciones; --ON DELETE RESTRICT;
ALTER TABLE uso ADD FOREIGN KEY(dni_usuarios) REFERENCES usuarios; --ON DELETE CASCADE;
ALTER TABLE uso ADD FOREIGN KEY(cod_bicicleta) REFERENCES bicicletas; --ON DELETE RESTRICT;
ALTER TABLE uso ADD FOREIGN KEY(estacion_llegada) REFERENCES estaciones; --ON DELETE RESTRICT;

INSERT INTO usuarios VALUES
('00000000A', 'Nombre1', 'Apellidos1', 'Calle 1', 000000000, 'email1@gmail.com', 'admin', 24),
('00000000B', 'Nombre2', 'Apellidos2', 'Calle 2', 000000001, 'email2@gmail.com', '12345678', 17),
('00000000C', 'Nombre3', 'Apellidos3', 'Calle 3', 000000002, 'email3gmail.com', '87654321', 52);

INSERT  INTO estaciones VALUES
('E00000', '00000', 'Calle 1', '00000', '00000'),
('E00001', '00001', 'Calle 2', '00001', '00001'),
('E00002', '00002', 'Calle 3', '00002', '00002'),
('E00003', '00003', 'Calle 4', '00003', '00003');

INSERT INTO bicicletas VALUES
(00000, 'marca1', 'modelo1', CURRENT_TIMESTAMP),
(00001, 'marca2', 'modelo2', CURRENT_TIMESTAMP),
(00002, 'marca3', 'modelo3', CURRENT_TIMESTAMP),
(00003, 'marca4', 'modelo4', CURRENT_TIMESTAMP),
(00004, 'marca5', 'modelo5', CURRENT_TIMESTAMP),
(00005, 'marca6', 'modelo6', CURRENT_TIMESTAMP),
(00006, 'marca7', 'modelo7', CURRENT_TIMESTAMP);

INSERT INTO uso VALUES
('E00000', CURRENT_TIMESTAMP, '00000000A', 00000, 'E00001', CURRENT_TIMESTAMP),
('E00000', CURRENT_TIMESTAMP, '00000000A', 00001, 'E00002', CURRENT_TIMESTAMP),
('E00003', CURRENT_TIMESTAMP, '00000000A', 00002, 'E00000', CURRENT_TIMESTAMP),
('E00002', CURRENT_TIMESTAMP, '00000000B', 00003, 'E00001', CURRENT_TIMESTAMP),
('E00000', CURRENT_TIMESTAMP, '00000000B', 00004, 'E00003', CURRENT_TIMESTAMP),
('E00003', CURRENT_TIMESTAMP, '00000000C', 00005, 'E00001', CURRENT_TIMESTAMP);


ALTER TABLE usuarios ADD COLUMN fecha_baja date;

