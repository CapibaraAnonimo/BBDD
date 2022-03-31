/*Queremos un listado de las reservas de los clientes (nombre y apellidos), así como del importe de las mismas
teniendo en cuenta el descuento. El listado ha de estar ordenado ascendentemente por fecha, la cual
también ha de reflejarse en el mismo.*/

SELECT nombre, apellido1, apellido2, precio * 1-(COALESCE(descuento, 0)/100), reserva.fecha_reserva
FROM cliente JOIN reserva USING(id_cliente)
	JOIN vuelo USING(id_vuelo)
WHERE descuento IS NOT NULL
ORDER BY fecha_reserva ASC;



/*Queremos un listado del número de vuelos de salida programados en cada aeropuerto para el més de abril.
La salida será:
nombre , mes, num_vuelos*/


SELECT COUNT(*), to_char(salida, 'Month'), aeropuerto.nombre
FROM vuelo JOIN aeropuerto ON(desde=id_aeropuerto)
WHERE EXTRACT(month FROM salida) = 4
GROUP BY nombre, to_char(salida, 'Month');



/*Queremos un listado del número total de vuelos de aquellos aeropuertos que han tenido al menos 50 vuelos
La salida será:
Nombre_aeropuerto, num_vuelos*/


WITH vuelosDesde AS(
	SELECT COUNT(*) "sumD", desde "de"
	FROM vuelo
	GROUP BY desde
),
vuelosHasta AS(
	SELECT COUNT(*) AS "sumH", hasta "ha"
	FROM vuelo
	GROUP BY hasta
)
SELECT nombre, (sumH) + (sumB)
FROM vuelosDesde JOIN vuelosHasta ON(de=ha)
	JOIN aeropuerto ON(de=id_aeropuerto);
--Dice que no exixste un dato cuando claramente existe, buenas tardes




/*Queremos un listado de aquellos aeropuertos en los cuales el Boeing 737-300 ha realizado un número de
vuelos mayor que el promedio de vuelos realizados por mes en 2021 en el correspondiente aeropuerto.*/


WITH vuelos AS(
	SELECT COUNT(*)
	FROM vuelo JOIN avion USING(id_avion)
	WHERE avion.nombre ILIKE 'Boeing 737-300'
)
SELECT nombre
FROM aeropuerto LEFT JOIN vuelo v1 ON(aeropuerto.id_aeropuerto=v1.desde)
	LEFT JOIN vuelo v2 ON(aeropuerto.id_aeropuerto=v2.hasta)
GROUP BY aeropuerto.nombre
HAVING (SELECT AVG(
	SELECT COUNT(desde)
	FROM vuelo v3 
	WHERE v1.desde = v3.desde 
	GROUP BY extract('month' FROM salida)
)) < (SELECT * FROM vuelos);



/*Se consideran aptos aquellos vuelos cuyas plazas están cubiertas al menos al 80% durante los meses de
verano (junio, julio, agosto y septiembre), ó al menos al 50% el resto del año.
Queremos un listado detallado de dichos vuelos, de la siguiente manera:
Aeropuerto, fecha_salida, avión, max_plaza, plazas_reservadas, plazas_disponibles
NOTA: ¡NO SE PUEDE EMPLEAR HAVING!*/


WITH vueloVerano AS(
	SELECT *
	FROM vuelo v1 JOIN avion USING(id_avion)
	WHERE 5 = ALL (SELECT *
		  FROM vuelo v2
		  WHERE vuelo v2.id_vuelo = v1.id_vuelo)
)
SELECT * ;



/*Necesitamos saber el promedio de pasajeros transportados por 'aeropuertos en uso' en cada mes de reserva.
El listado mostrará:
mes, pasajeros_por_aeropuertos, num_aeropuertos*/

SELECT to_char(salida, 'MM'), 
FROM aeropuerto JOIN vuelo ON(id_aeropuerto=desde)
GROUP BY to_char(salida, 'MM');













