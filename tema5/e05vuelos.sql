SELECT aeropuerto.nombre AVG
FROM reserva JOIN vuelo USING(id_vuelo)
		JOIN aeropuerto ON(desde=id_aeropuerto)
		JOIN (
			
				)
GROUP BY aeropuerto.nombre