--1. En la base de datos de climatología, crea una función que reciba una fecha, y devuelva la 
--temperatura máxima de ese día.

DROP FUNCTION IF EXISTS tempMax;

CREATE FUNCTION tampMax(fecha date) returns numeric AS
$$
Begin
	SELECT temperatura_maxima
	FROM climatologia
	WHERE fecha = $1;
END;
$$
LANGUAGE plpgsql;

SELECT * 
FROM tempMax(DATE '2019-2-11');