CREATE OR REPLACE FUNCTION promedioHabitantesOUT(ano1 int, ano2 int, OUT promedio numeric)
AS
$$
	SELECT AVG(hombres + mujeres)
	FROM demografia_basica
	WHERE provincia ILIKE 'Sevilla'
	  AND (anio >= ano1 AND anio <= ano2);
$$
LANGUAGE 'sql';

SELECT promedioHabitantesOUT(2015, 2017);


CREATE OR REPLACE FUNCTION promedioHabitantesRETURN(ano1 int, ano2 int)
RETURNS numeric
AS
$$
DECLARE
	suma numeric := 0;
	i numeric := (ano2 - ano1 -1);
	aux1 numeric;
	aux2 numeric;
BEGIN
	LOOP
		aux1 := suma;
		SELECT AVG(hombres + mujeres) INTO aux2
		FROM demografia_basica
		WHERE provincia ILIKE 'Sevilla'
	  	  AND anio = (ano1 + i);
		suma := aux1 + aux2;
		IF i = 0 THEN
			EXIT;
		END IF;
		i := i - 1;
	END LOOP;
	SELECT (suma / (ano2-ano1));
END;
$$
LANGUAGE plpgsql;