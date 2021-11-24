SELECT *
FROM inmueble i JOIN operacion USING(id_inmueble)
	 JOIN tipo ON (tipo_inmueble = id_tipo)
WHERE tipo_operacion = 'Venta'
  AND provincia = 'Sevilla'
  AND EXTRACT(year from fecha_operacion) = 2019
  AND nombre = 'Piso'
ORDER BY precio_final DESC
LIMIT 3;



SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE TO_CHAR(fecha_operacion, 'TMMonth')
			IN('Julio', 'Agosto')
			
			
SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE provincia IN ('Cordova', 'Jaén')
  AND EXTRACT(year from fecha_operacion)
  		IN (2019, 2020)
  AND EXTRACT(month from fecha_operacion) >= 10
  AND tipo_operacion = 'Venta';
  
  
SELECT * 
FROM  inmueble JOIN operacion USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE TO_CHAR(fecha_operacion, 'ID')
		BETWEEN '1' AND '5'
  AND tipo.nombre = 'Parking'
  AND tipo_operacion = 'Venta';
  
  
SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE tipo_operacion ='Venta'
  AND provincia = 'Granada'
  AND nombre = 'Piso'
  AND age(fecha_operacion, fecha_alta)
  		BETWEEN make_interval(months => 3)
			AND make_interval(months <= 6);



