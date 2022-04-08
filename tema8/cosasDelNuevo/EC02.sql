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
	aeSalida text,
	ciuSalida text,
	feSalida date,
	aeLlegada text,
	ciuLlegada text,
	feLlegada date,
	pasaMax numeric,
	pasajeros numeric
) AS
$$
	with pasajerosVuelo AS(
		SELECT COUNT(*) "total", id_vuelo
		FROM reserva
		GROUP BY id_vuelo
	)
	SELECT ae1.nombre, ae1.ciudad, salida, ae2.nombre, ae2.ciudad, salida, max_pasajeros, total
	FROM vuelo JOIN reserva USING(id_vuelo)
		JOIN pasajerosVuelo USING(id_vuelo)
		JOIN aeropuerto ae1 ON(desde=ae1.id_aeropuerto)
		JOIN aeropuerto ae2 ON(hasta=ae2.id_aeropuerto)
		JOIN avion USING(id_avion)
	WHERE (date(salida) = fechas OR date(llegada) = fechas) AND (ae1.nombre ILIKE lugar OR ae1.ciudad ILIKE lugar 
																 OR ae2.nombre ILIKE lugar OR ae2.ciudad ILIKE lugar )
$$
LANGUAGE 'sql'

SELECT * FROM aeropuertoFecha('27-06-2021', 'Ámsterdam');
























