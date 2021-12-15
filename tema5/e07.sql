SELECT ae1.nombre, (SELECT ROUND(AVG( 
	(SELECT COUNT(*) FROM reserva WHERE reserva.id_vuelo = v1.id_vuelo)
	/(SELECT max_pasajeros FROM avion WHERE avion.id_avion = v1.id_avion)*100 
									), 2
								)
				   )
FROM vuelo v1 JOIN aeropuerto ae1 ON(desde=id_aeropuerto)
		JOIN reserva r1 USING(id_vuelo)
		JOIN avion a1 USING(id_avion)
GROUP BY ae1.nombre;


SELECT EXTRACT(month FROM v2.salida), ( 
	(SELECT COUNT(*) 
	 FROM vuelo v1
	 WHERE EXTRACT(month FROM v1.salida) = EXTRACT(month FROM v2.salida)
	 GROUP BY EXTRACT(month FROM v1.salida))
	 UNION
	(SELECT COUNT(*) 
	 FROM vuelo v3
	 WHERE EXTRACT(month FROM v3.salida) = EXTRACT(month FROM v2.salida)
	 GROUP BY EXTRACT(month FROM v3.salida)))
FROM vuelo v2
GROUP BY EXTRACT(month FROM v2.salida);


SELECT *
FROM vuelo;


SELECT nombre, apellido1, apellido2
FROM cliente JOIN reserva USING(id_cliente)
WHERE id_cliente NOT IN (
	SELECT id_cliente
	FROM reserva r1 JOIN cliente c1 USING(id_cliente)
	WHERE r1.id_cliente = c1.id_cliente);




--Ejercicio 5	
SELECT c1.nombre, c1.apellido1, c1.apellido2
FROM cliente c1 JOIN reserva r1 USING(id_cliente)
		JOIN vuelo v1 USING(id_vuelo)
		JOIN aeropuerto a1 ON(desde=id_aeropuerto)
WHERE (SELECT precio*(100-descuento)/100
FROM reserva r1 JOIN vuelo v1 USING(id_vuelo)
WHERE r1.id_cliente NOT IN(
	SELECT c2.id_cliente
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
						)) > (SELECT (SELECT SUM(precio*(100-descuento)/100)
FROM reserva r1 JOIN vuelo v1 USING(id_vuelo)
WHERE r1.id_cliente IN(
	SELECT c2.id_cliente
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
						))/(
								SELECT COUNT(DISTINCT c2.id_cliente)
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
							))


--Dinero total de los vuelos de fuera
SELECT SUM(precio*(100-descuento)/100)
FROM reserva r1 JOIN vuelo v1 USING(id_vuelo)
WHERE r1.id_cliente IN(
	SELECT c2.id_cliente
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
						)
--Dinero medio de los vuelos de fuera
SELECT (SELECT SUM(precio*(100-descuento)/100)
FROM reserva r1 JOIN vuelo v1 USING(id_vuelo)
WHERE r1.id_cliente IN(
	SELECT c2.id_cliente
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
						))/(
								SELECT COUNT(DISTINCT c2.id_cliente)
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
							)

--Dinero de la gente de dentro
SELECT precio*(100-descuento)/100
FROM reserva r1 JOIN vuelo v1 USING(id_vuelo)
WHERE r1.id_cliente NOT IN(
	SELECT c2.id_cliente
	FROM  cliente c2 JOIN reserva r2 USING(id_cliente)
			JOIN vuelo v2 USING(id_vuelo)
			JOIN aeropuerto a2 ON(v2.desde=a2.id_aeropuerto)
	WHERE a2.ciudad NOT IN('Sevilla', 'Málaga', 'Madrid', 'Bilbao', 'Barcelona')
						)



