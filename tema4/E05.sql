SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE provincia ILIKE 'sevilla'
  AND tipo_operacion ILIKE 'Venta'
  AND EXTRACT(year FROM fecha_operacion)::numeric = 2019
ORDER BY precio_final DESC
LIMIT 3;


SELECT AVG(precio_final/12)
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE provincia ILIKE 'Málaga'
  AND EXTRACT(month FROM fecha_operacion) IN (7, 8)
    AND tipo_operacion ILIKE 'Alquiler';
	
	
SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE provincia IN ('Jaén', 'Córdoba')
  AND EXTRACT(year FROM fecha_operacion)::numeric IN (2019, 2020)
  AND EXTRACT(month FROM fecha_operacion)::numeric IN (10, 11, 12)
  AND tipo_operacion ILIKE 'Venta';
  
  
SELECT AVG(precio_final)
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE tipo_inmueble = 6
  AND tipo_operacion ILIKE 'Venta'
  AND provincia ILIKE 'Huelva';
  

SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE (fecha_operacion - fecha_alta) BETWEEN 90 AND 180
  AND provincia ILIKE 'Granada'
  AND tipo_inmueble = 5;


SELECT provincia, fecha_alta
FROM inmueble JOIN tipo ON(tipo_inmueble=id_tipo)
	 JOIN operacion ON(fecha_alta=fecha_operacion)
WHERE nombre ILIKE 'Industrial'
  AND EXTRACT(year FROM fecha_operacion)::numeric = 2019
ORDER BY fecha_alta;










