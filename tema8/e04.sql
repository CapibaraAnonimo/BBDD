--Ejercicio 1
CREATE OR REPLACE FUNCTION GASTO_POR_CLIENTE_FECHA(desde date, hasta date)
returns table(id integer, nombre text, apellido text, suma numeric)
AS $$
	SELECT id_cliente, nombre, apellido1, SUM(precio)
	FROM reserva JOIN vuelo USING(id_vuelo)
			JOIN cliente USING(id_cliente)
	WHERE fecha_reserva BETWEEN $1 AND $2
	GROUP BY id_cliente, nombre, apellido1;
$$
LANGUAGE 'sql'

SELECT * FROM GASTO_POR_CLIENTE_FECHA('2021-05-19', '2021-08-19');


--Ejercicio 2

CREATE OR REPLACE FUNCTION MEDIA_DIARIA_VUELOS_SALIDA_AEROPUERTO(nombre text)
RETURNS TABLE(dia numeric, cantidad numeric)
AS $$
	WITH aeropuertos AS(
		SELECT salida::date "Fecha", COUNT(*) "Suma"
		FROM vuelo JOIN aeropuerto ON(desde = id_aeropuerto)
		WHERE nombre ILIKE $1
		GROUP BY salida::date
	)
	SELECT *
	FROM aeropuertos;
$$
LANGUAGE 'sql'

SELECT * FROM MEDIA_DIARIA_VUELOS_SALIDA_AEROPUERTO('Barajas')


