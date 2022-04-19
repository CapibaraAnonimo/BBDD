/*1. En la base de datos VUELOS (varias tablas) crea una función que reciba el identificador de un vuelo y devuelva un
número entero con la cantidad de reservas que hay para dicho vuelo.*/


CREATE OR REPLACE FUNCTION countReservas(idvuelo numeric)
RETURNS numeric AS
$$
	SELECT COUNT(*)
	FROM reserva
	WHERE id_vuelo = $1
$$
LANGUAGE 'sql'

SELECT * FROM countReservas(4);



/*2. En la misma base de datos, crea una función que reciba una fecha y una cadena de caracteres y seleccione todos 
los vuelos que salen o llegan ese día de un aeropuerto o ciudad cuyo nombre sea el que se ha pasado como segundo 
argumento (la cadena de caracteres). El resultado a mostrar debe ser: aeropuerto de salida, ciudad de salida, fecha y 
hora de salida, aeropuerto de llegada, ciudad de llegada, fecha y hora de llegada, nº máximo de pasajeros del avión, 
nº de reservas que hay actualmente (para mostrar este último argumento, debes utilizar la función definida en el 
apartado anterior.*/


CREATE OR REPLACE FUNCTION aeropuertoFecha(fechas date, lugar text)
RETURNS TABLE(
	idvuelo integer,
	aeSalida text,
	ciuSalida text,
	feSalida timestamp,
	aeLlegada text,
	ciuLlegada text,
	feLlegada timestamp,
	pasaMax numeric,
	pasajeros numeric
) AS
$$
	with pasajerosVuelo AS(
		SELECT COUNT(*) "total", id_vuelo
		FROM reserva
		GROUP BY id_vuelo
	)
	SELECT id_vuelo, ae1.nombre, ae1.ciudad, salida, ae2.nombre, ae2.ciudad, llegada, max_pasajeros, total
	FROM vuelo JOIN reserva USING(id_vuelo)
		JOIN pasajerosVuelo USING(id_vuelo)
		JOIN aeropuerto ae1 ON(desde=ae1.id_aeropuerto)
		JOIN aeropuerto ae2 ON(hasta=ae2.id_aeropuerto)
		JOIN avion USING(id_avion)
	WHERE (date(salida) = fechas OR date(llegada) = fechas) AND (ae1.nombre ILIKE lugar OR ae1.ciudad ILIKE lugar 
																 OR ae2.nombre ILIKE lugar OR ae2.ciudad ILIKE lugar )
$$
LANGUAGE 'sql'

SELECT * FROM aeropuertoFecha('30-06-2021', 'Ámsterdam');



/*3. En la misma base de datos, crea una función que nos permita crear un nuevo vuelo. Debe recibir como argumento: 
ciudad de salida, ciudad de llegada, fecha y hora de salida, fecha y hora de llegada, precio y descuento. Debe 
insertar una nueva fila en vuelo, obteniendo el ID de los aeropuertos a partir de sus nombres, y estableciendo un 
avión aleatorio (puedes consultar cómo obtener una fila aleatoria de una tabla en este enlace: http://blog.jmacoe.com/
gestion_ti/base_de_datos/sql-para-seleccionar-una-fila-aleatoriamente/ */


CREATE OR REPLACE FUNCTION crearVuelo(ciudadSalida text, ciudadLlegada text, fechaSalida timestamp, 
									  fechaLlegada timestamp, precio numeric, descuento numeric)
RETURNS void AS
$$
	INSERT INTO vuelo VALUES((SELECT MAX(id_vuelo)+1 FROM vuelo), 
							 (SELECT id_aeropuerto FROM aeropuerto WHERE ciudad ILIKE $1), 
							 (SELECT id_aeropuerto FROM aeropuerto WHERE ciudad ILIKE $2), ($3), ($4), ($5), ($6), 
							 (SELECT id_avion FROM avion ORDER BY RANDOM() LIMIT 1))
$$
LANGUAGE 'sql'

SELECT * FROM crearVuelo('Sevilla', 'Ámsterdam', make_timestamp(2021, 06, 23, 6, 34, 0), 
						 make_timestamp(2021, 06, 23, 8, 29, 0), 54, 32);
SELECT *
FROM vuelo
ORDER BY id_vuelo DESC

























