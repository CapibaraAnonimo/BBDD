SELECT TO_CHAR(salida, 'ID'), age(llegada, salida)
FROM vuelo
WHERE age(llegada, salida) >=(
	FROM (
		SELECT MIN(age(llegada, salida)) "tiempo"
		FROM vuelo
		WHERE TO_CHAR(salida, 'ID')
		  AND age(llegada, salida) 
			) datos
								)
--Si se quiere poner unicamente 3 aquí iría un LIMIT 3, pero al ser todas iguales se tendría sentido 
--dejarlo así (para mí al menos)
