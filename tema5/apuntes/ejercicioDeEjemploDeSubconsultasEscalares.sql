--Selecciona el % de ocupaciones de los vuelos que salen de Sevilla.
--Debemos mostrar el aeropuerto de salida, de llegada, la fecha de salida, 
--llegada, el nº de ocupantes del vuelo y el % de ocupacion

SELECT a1.nombre, a2.nombre, salida, llegada, max_pasajeros, 
	(SELECT COUNT(*)/max_pasajeros*100
	FROM vuelo v3
	WHERE v3.id_vuelo = v1.id_vuelo)
FROM avion JOIN vuelo v1 USING(id_avion)
		JOIN aeropuerto a1 ON(desde=a1.id_aeropuerto)
		JOIN aeropuerto a2 ON(hasta=a2.id_aeropuerto)