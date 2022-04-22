CREATE OR REPLACE FUNCTION tablaMultiplicar(nn1 integer)
RETURNS TABLE(
	n1 int,
	n2 int,
	n3 int
) AS
$$
DECLARE
BEGIN
	SELECT $1, generate_series(0, 10) "multiplicador", (multiplicador * $1);
END;
$$
LANGUAGE plpgsql;

SELECT tablamultiplicar(4);