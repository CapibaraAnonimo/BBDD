/*1. En la base de datos VUELOS (varias tablas), debes crear una función, llamada GASTO_POR_CLIENTE_FECHA, que sea capaz
de devolver el nombre del cliente y la suma del gasto realizado por cada cliente entre dos fechas que se le pasen como 
parámetro. Por tanto, la función:
a. Recibirá la fecha de inicio y de fin de la consulta.
b. Devolverá una tabla con 4 columnas: id del cliente, nombre, apellidos, suma del gasto de dicho cliente.*/

CREATE OR REPLACE FUNCTION gastosCliente(ano1 numeric, ano2 numeric)
RETURNS table(
	idCliente numeric,
	nombre text,
	apellidos text,
	gastos numeric
)AS
$$
	SELECT id_cliente, nombre, apellido1, apellido2, SUM(precio)
	FROM reserva JOIN vuelo USING(id_vuelo)
		JOIN cliente USING(id_cliente)
	WHERE EXTRACT(year FROM fecha reserva) >= ano1 AND EXTRACT(year FROM fecha reserva) <= ano2
	GROUP BY id_cliente, nombre, apellido1, apellido2
$$
LANGUAGE plpgsql;