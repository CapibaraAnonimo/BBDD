SELECT *
FROM inmueble JOIN operacion USING(id_inmueble)
	 JOIN vendedor USING(id_vendedor)
WHERE ((to_char(fecha_operacion, 'ID') = '1'
	  AND EXTRACT(month FROM fecha_operacion) = 02)
   OR (to_char(fecha_operacion, 'ID') = '7'
	  AND EXTRACT(month FROM fecha_operacion) = 03))
  AND superficie > 200
  AND nombre ILIKE '%A%';
  
  
SELECT AVG(precio/superficie)
FROM inmueble
WHERE tipo_inmueble IN(1, 5)
  AND EXTRACT(month FROM fecha_alta) IN(3, 4)
  AND provincia IN('Cádiz', 'Granada', 'Huelva', 'Málaga', 'Almería');
  
  
SELECT AVG(ABS((precio/precio_final)*100 - 100))
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE tipo_operacion ILIKE 'Alquiler'
  AND EXTRACT(month FROM fecha_alta) IN(3, 4)
  AND tipo_inmueble IN(4, 3, 7);
  

SELECT nombre
FROM inmueble JOIN operacion USING(id_inmueble)
	 JOIN comprador USING(id_cliente)
WHERE tipo_inmueble IN(1,5)
  AND provincia IN('Jaén', 'Córdoba')
  AND precio_final BETWEEN 150.000 AND 200.000
  AND fecha_operacion - fecha_alta BETWEEN 90 AND 120;
  

SELECT AVG(precio) AS "precio inicial medio", AVG(precio_final) AS "precio final medio", 
		AVG( ABS( (AVG(precio) / AVG(precio_final) ))*100 - 100 )  AS "diferencia de porcentaje"
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE tipo_inmueble IN(1,5)
  AND tipo_operacion ILIKE 'Alquiler'
  AND superficie < 100
  AND fecha_operacion - fecha_alta >= 365;
  

SELECT precio_final
FROM inmueble JOIN operacion USING(id_inmueble)
WHERE tipo_inmueble IN(1,5)
  AND tipo_operacion ILIKE 'Alquiler'
  AND EXTRACT(month FROM fecha_operacion) IN(7, 8)
  AND provincia ILIKE 'Huelva'
ORDER BY precio_final DESC
LIMIT 1;








