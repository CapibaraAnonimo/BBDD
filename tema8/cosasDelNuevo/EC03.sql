CREATE OR REPLACE FUNCTION tablaMultiplicar(integer)
RETURNS TABLE(
	numero int,
	numero int,
	numero int
)
$$
BEGIN
END;
	SELECT $1, generate_series(0, 10, 1) "multiplicador", (multiplicador * $1)
$$
LANGUAGE 'plpgsql'