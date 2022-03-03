CREATE OR REPLACE FUNCTION sumarDosNUmeros(num1 numeric, num2 numeric)
RETURNS numeric AS
$$
BEGIN
	return $1 + $2;
END;
$$
LANGUAGE plpgsql;

SELECT sumarDosNUmeros(1, 2);

SELECT version();



CREATE OR REPLACE FUNCTION actualizarVuelo(precioOiginal numeric, descuento numeric)
RETURNS void AS
$$
BEGIN
	UPDATE vuelo SET precio = $2 WHERE precio < $1 AND precio > $2;
END;
$$
LANGUAGE plpgsql;

SELECT actualizarVuelo(100, 50);

SELECT * FROM vuelo;


CREATE OR replace FUNCTION salvar()
RETURNS boolean AS
$$
BEGIN
	COPY(SELECT * FROM aeropuerto) TO 'C:\Users\arnaiz.caadr22\Documents\BBDD\tema8\aeropuerto' with CSV;
	RETURN true;
END;
$$
LANGUAGE plpgsql;

SELECT salvar();