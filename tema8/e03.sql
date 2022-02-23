--Ejercicio 1

CREATE OR REPLACE FUNCTION tabla(numero numeric)
returns table(numeroDado numeric, numeroSerie numeric, resultado numeric)
AS $$
	WITH numbers AS (
  SELECT *
  FROM generate_series(1, 10)
)
	SELECT $1, generate_series, ($1*generate_series)
	FROM numbers;
$$
LANGUAGE 'sql'

SELECT * FROM tabla(3)


--Ejercicio 2

CREATE OR REPLACE FUNCTION numeroHabitantesA(OUT desde integer, OUT hasta integer )
AS $$
	SELECT AVG(hombres + mujeres)
	FROM demografia_basica
	WHERE anio BETWEEN $1 and $2;
$$
LANGUAGE 'sql'

SELECT * FROM numeroHabitantesA(2005, 2008)



