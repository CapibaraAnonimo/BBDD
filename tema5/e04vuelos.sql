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


SELECT *
FROM cliente JOIN reserva USING(id_cliente)
GROUP BY id_cliente
HAVING 