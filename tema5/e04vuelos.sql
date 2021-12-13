SELECT *
FROM vuelo v1
WHERE llegada - salida >= (
	SELECT llegada - salida
	FROM vuelo v2
	WHERE (v2.llegada - v2.salida) = (v1.llegada - v1.salida)
							)