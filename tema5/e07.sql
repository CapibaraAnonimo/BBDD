--Ejercicio 1
SELECT ae1.nombre, (SELECT ROUND(AVG( 
	(SELECT COUNT(*) FROM reserva WHERE reserva.id_vuelo = v1.id_vuelo)
	/
	(SELECT max_pasajeros FROM avion WHERE avion.id_avion = v1.id_avion)*100 
									), 2
								)
				   )
FROM vuelo v1 JOIN aeropuerto ae1 ON(desde=id_aeropuerto)
		JOIN reserva r1 USING(id_vuelo)
		JOIN avion a1 USING(id_avion)
GROUP BY ae1.nombre;

--Corrección
WITH ocupacion_por_vuelo AS (
	SELECT nombre, id_vuelo, COUNT(id_reserva), round(COUNT(id_reserva) /
													 (SELECT max_pasajeros
													 FROM avion
													 WHERE v.id_avion = id_avion)::numeric*100, 2) ""
)


--Ejercicio 2
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

--Corrección
SELECT mes, nombre, SUM(numero)
FROM (SELECT YO_CHAR(salida, 'TMMonth') "mes", nombre, COUNT(id_reserva) "numero", 'salida'
	 FROM vuelo JOIN aeropuerto ON(desde=id_aeropuerto)
	 		JOIN reserva USING(id_vuelo)
	 GROUP BY to_CHAR(llegada, 'TMMonth'), nombre)
	 UNION
	 (SELECT TO_CHAR(llegada, 'TMMonth') "mes", nombre, COUNT(id_reserva) "numero", 'legada'
	 FROM vuelo JOIN aeropuerto ON(hasta=id_aeropuerto)
	 		JOIN reserva USING(id_vuelo)
	 )


--Ejercicio 3
SELECT *
FROM vuelo;

--Correción
WITH suma_po_trayecto AS(
	SELECT
)


--Ejercicio 4
SELECT nombre, apellido1, apellido2
FROM cliente JOIN reserva USING(id_cliente)
WHERE id_cliente NOT IN (
	SELECT id_cliente
	FROM reserva r1 JOIN cliente c1 USING(id_cliente)
	WHERE r1.id_cliente = c1.id_cliente);

--Corrección
SELECT DISTINCT nombre, apellido1, apellido2
FROM cliente
WHERE id_cliente NOT IN(
	SELECT c.id_cliente
	FROM cliente c JOIN reserva USING(id_cliente)
			JOIN vuelo USING (id_vuelo)
			JOIN aeropuerto ae ON(desde=id_aeropuerto)
	WHERE TO_CHAR(salida, 'q') = '3'
	  AND ae.ciudad = 'Sevilla'
);


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
--Correción
WITH gasto_por_cliente AS (
		SELECT SUM(COALESCE(PRECIO * (1 - (DESCUENTO::numeric / 100)),PRECIO)) sumval
		FROM VUELO VU JOIN AEROPUERTO AER ON (VU.HASTA = AER.ID_AEROPUERTO)
				JOIN RESERVA USING (ID_VUELO)
		WHERE UPPER(AER.CIUDAD) NOT IN ('SEVILLA','MÁLAGA','MADRID','BILBAO','BARCELONA')
		GROUP BY ID_CLIENTE
), gasto_medio AS (
		SELECT AVG(sumval) as "media"
		FROM gasto_por_cliente
)
SELECT CL.NOMBRE "NOMBRE", APELLIDO1, APELLIDO2, 
		SUM(COALESCE(PRECIO * (1 - (DESCUENTO::numeric / 100)),PRECIO)) "GASTO"
FROM CLIENTE CL JOIN RESERVA USING (ID_CLIENTE)
JOIN VUELO V USING (ID_VUELO)
JOIN AEROPUERTO AE ON (V.DESDE = AE.ID_AEROPUERTO)
WHERE UPPER(AE.CIUDAD) IN ('SEVILLA','MÁLAGA','MADRID','BILBAO','BARCELONA')
GROUP BY CL.NOMBRE, APELLIDO1, APELLIDO2
HAVING SUM(COALESCE(DESCUENTO, PRECIO * (1 - (DESCUENTO / 100)),PRECIO)) >=
		(SELECT media
		 FROM gasto_medio);


