SELECT to_char(v1.salida, 'ID'), age(llegada, salida), a1.nombre, a2.nombre, TO_CHAR(salida, 'YYYY:MM:DD:HH12:MI'), 
		TO_CHAR(llegada, 'YYYY:MM:DD:HH12:MI')
FROM vuelo v1 JOIN aeropuerto a1 ON(v1.desde=a1.id_aeropuerto)
		JOIN aeropuerto a2 ON(v1.hasta=a2.id_aeropuerto)
WHERE age(llegada, salida) >= ALL(
	SELECT age(llegada, salida)
	FROM vuelo v2
	WHERE to_char(v1.salida, 'ID') = to_char(v2.salida, 'ID')
							)
ORDER BY to_char(v1.salida, 'ID'), age(llegada, salida) DESC;

--Correccion
SELECT to_char(v1.salida, 'TMDay'), a1.nombre, a2.nombre, TO_CHAR(salida, 'YYYY:MM:DD:HH12:MI'), 
		TO_CHAR(llegada, 'YYYY:MM:DD:HH12:MI')
FROM vuelo v1 JOIN aeropuerto a1 ON(v1.desde=a1.id_aeropuerto)
		JOIN aeropuerto a2 ON(v1.hasta=a2.id_aeropuerto)
WHERE age(llegada, salida) >= ALL(
	SELECT age(llegada, salida)
	FROM vuelo v2
	WHERE to_char(v1.salida, 'TMDay') = to_char(v2.salida, 'TMDay')
									)
ORDER BY to_char(v1.salida, 'ID');



SELECT 
FROM cliente JOIN reserva USING(id_cliente)
GROUP BY id_cliente
HAVING id_cliente = 0;

--Correccion

SELECT vuelo.*, COALESCE(precio * (1 - (descuento::numeric/100)), precio)
FROM vuelo v1 JOIN aeropuerto a1 ON(desde=id_aeropuerto)
WHERE 

SELECT c2.nombre, a2.nombre, a2.ciudad, SUM(COALESCE(precio * (1 - (descuento::numeric/100)), precio)) "total"
FROM vuelo v1 JOIN aeropuerto a2 ON(desde=id_aeropuerto)
		JOIN reserva USING(id_vuelo)
		JOIN cliente c2 USING(id_cliente)
GROUP BY c2.nombre, a2.nombre, a2.ciudad
HAVING SUM(COALESCE(precio * (1 - (descuento::numeric/100)), precio)) >= ALL(
	SELECT SUM(COALESCE(precio * (1 - (descuento::numeric/100)), precio))
	FROM vuelo v2 JOIN aeropuerto a3 ON(desde=id_aeropuerto)
			JOIN reserva USING(id_vuelo)
			JOIN cliente c3 USING(id_cliente)
	WHERE a2.nombre = a3.nombre
	GROUP BY c3.nombre, a3.nombre, a3.ciudad
																				)