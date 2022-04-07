/*1. En la base de datos de climatología, crea una función que reciba una fecha, y devuelva la temperatura máxima de 
ese día.*/

CREATE OR REPLACE FUNCTION temperaturaMaximaDia(fecha2 date)
RETURNS numeric AS
$$
	SELECT MAX(temperatura_maxima)
	FROM climatologia
	WHERE fecha = fecha2
$$
LANGUAGE 'sql'

SELECT * FROM temperaturaMaximaDia('29-4-2019');



/*2. Modifica la función anterior para que devuelva, además de la temperatura máxima, la estación donde se ha 
registrado. Si se hubiera registrado en más de una estación puedes:
a. Escoger solamente la primera por orden alfabético.
b. Investigar el uso de la función ARRAY_AGG 
(https://www.postgresqltutorial.com/postgresql-aggregate-functions/postgresql-array_agg-function/) y mostrar todas 
las estaciones separadas por comas.*/


CREATE OR REPLACE FUNCTION temperaturaMaximaEstacionDia(fecha2 date)
RETURNS TABLE(
	temperatura numeric,
	estacion text
) AS
$$
	with maxTemp AS(
		SELECT MAX(temperatura_maxima) "max"
		FROM climatologia
		WHERE fecha = $1
	)
	SELECT temperatura_maxima , ARRAY_AGG(estacion)
	FROM climatologia 
	WHERE fecha = $1 AND temperatura_maxima = (SELECT * FROM maxTemp)
	GROUP BY temperatura_maxima
$$
LANGUAGE 'sql'

SELECT * FROM temperaturaMaximaEstacionDia('24-10-2019');



/*3. Crea una función que reciba como parámetros los siguientes:
a. Fecha de inicio y fecha de fin
b. Nombre de la estación
La función debe devolver la temperatura máxima media y la temperatura mínima media para la estación que se pase como 
argumento, entre las fechas que se han pasado también como argumento (dichas fechas deben quedar incluidas en el 
intervalo).*/


CREATE OR REPLACE FUNCTION temperaturaMediaMaxMin(finicio date, ffinal date, estac text)
RETURNS TABLE(
	media_max numeric,
	media_min numeric
) AS
$$
	WITH maxT AS(
		SELECT MAX(temperatura_media) "max"
		FROM climatologia
		WHERE $1 <= fecha AND $2 >= fecha AND estacion ILIKE estac
	),
	minT AS(
		SELECT MIN(temperatura_media) "min"
		FROM climatologia
		WHERE $1 <= fecha AND $2 >= fecha AND estacion ILIKE estac
	)
	SELECT (SELECT * FROM maxT), (SELECT * FROM MINT)
$$
LANGUAGE 'sql'

SELECT * FROM temperaturaMediaMaxMin('24-10-2019', '1-12-2019', 'Rincón de la Victoria');










