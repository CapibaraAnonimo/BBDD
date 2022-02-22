--Ejercicio 1

DROP FUNCTION IF EXISTS reservas;

CREATE OR REPLACE FUNCTION reservas(idVuelo numeric) 
RETURNS numeric AS
$$
		SELECT COUNT(id_vuelo)
		FROM reserva
		WHERE id_vuelo = $1;
$$
LANGUAGE sql;

SELECT *
FROM reservas(7);


--Ejercicio 2

DROP FUNCTION IF EXISTS vuelos;

CREATE OR REPLACE FUNCTION vuelos(fecha date, nombre text) 
RETURNS TABLE(
				nombre1 text,
				ciudad1 text,
				salida date,
				nombre2 text,
				ciudad2 text,
				llegada date) AS
$$
		SELECT desde.nombre, desde.ciudad, v1.salida, hasta.nombre, hasta.ciudad, v1.llegada
		FROM vuelo v1 JOIN aeropuerto desde ON(v1.desde=desde.id_aeropuerto)
			JOIN aeropuerto hasta ON(v1.hasta=hasta.id_aeropuerto)
		WHERE ($1 = DATE(v1.salida) AND ($2 ILIKE desde.nombre OR $2 ILIKE desde.ciudad))
				OR ($1 = DATE(v1.llegada) AND ($2 ILIKE hasta.nombre OR $2 ILIKE hasta.ciudad))
$$
LANGUAGE sql;

SELECT * FROM vuelos('2021-06-27'::date, 'Ámsterdam'::text);


--Ejercicio 3





