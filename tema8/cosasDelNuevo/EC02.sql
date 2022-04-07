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