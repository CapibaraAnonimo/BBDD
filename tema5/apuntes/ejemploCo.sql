SELECT a1.nombre, a2.nombre, v1.salida, v1.llegada, age(llegada, salida) "tiempo"
FROM aeropuerto a1 JOIN vuelo v1 ON(desde=a1.id_aeropuerto)
		JOIN aeropuerto a2 ON(hasta=a2.id_aeropuerto)
WHERE age(llegada, salida) <= ALL(
	SELECT age(llegada, salida)
	FROM vuelo v2
	WHERE v1.desde = v2.desde
									)
ORDER BY a1.nombre;