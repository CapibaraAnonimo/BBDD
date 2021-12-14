SELECT nombre, COUNT(nombre) "trafico"
FROM vuelo JOIN aeropuerto ON(hasta=id_aeropuerto)
WHERE EXTRACT(month FROM llegada) IN ('01', '02', '03')
GROUP BY nombre
HAVING COUNT(nombre) <= (
	SELECT MAX(llegadas3) "llegadas2"
	FROM (
		SELECT COUNT(nombre) "llegadas3"
		FROM vuelo JOIN aeropuerto ON(hasta=id_aeropuerto)
		WHERE EXTRACT(month FROM llegada) IN ('01', '02', '03')
		GROUP BY nombre
		ORDER BY llegadas3
		LIMIT 3
			) "datos"
						)
ORDER BY trafico DESC;

--Correccion
SELECT nombre, ciudad, count(id_reserva)
FROM reserva JOIN vuelo USING(id_vuelo)
		JOIN aeropuerto ON(hasta=id_aeropuerto)
WHERE EXTRACT(MONTH FROM llegada) IN (1, 2, 3)
GROUP BY nombre;


SELECT a1.nombre "desde", a2.nombre "hasta", llegada - salida
FROM vuelo JOIN aeropuerto a1 ON(desde=a1.id_aeropuerto)
		JOIN aeropuerto a2 ON(hasta=a2.id_aeropuerto)
WHERE  llegada - salida <= (
	SELECT MAX(lista)
	FROM (
		SELECT llegada - salida AS "lista"
		FROM vuelo
		ORDER BY llegada - salida
		LIMIT 10
			) "datos"
							)
ORDER BY llegada - salida;

SELECT nombre, ROUND(SUM(precio*(100- COALESCE(descuento, 0)/100)), 2)
FROM vuelo JOIN avion USING(id_avion)
WHERE to_char(salida, 'ID') IN ('7', '6', '5')
  AND EXTRACT(month FROM salida) IN ('7', '8')
GROUP BY nombre;