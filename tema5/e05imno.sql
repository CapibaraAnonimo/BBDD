SELECT comprador.*, i.*, o.*
FROM operacion o JOIN inmueble i USING(id_inmueble)
		JOIN comprador USING(id_cliente)
		JOIN tipo t1 ON(tipo_inmueble=id_tipo)
WHERE t1.nombre ILIKE 'piso'
  AND i.tipo_operacion ILIKE 'Venta'
  AND precio_final >= ALL(
			  SELECT precio_final
			  FROM operacion o2 JOIN inmueble i2 USING(id_inmueble)
				JOIN tipo t2 ON(tipo_inmueble=id_tipo)
			  WHERE t2.nombre ILIKE 'Piso'
				AND i2.tipo_operacion ILIKE 'venta'
				AND i.provincia = i2.provincia
  							);


SELECT TO_CHAR(o1.fecha_operacion, 'TMMONTH'), i.provincia, comprador.nombre, o1.fecha_operacion, o1.precio_final
FROM operacion o1 JOIN inmueble i USING(id_inmueble)
		JOIN comprador USING(id_cliente)
		JOIN tipo t1 ON(tipo_inmueble=id_tipo)
WHERE t1.nombre ILIKE 'casa'
  AND i.tipo_operacion ILIKE 'alquiler'
  AND precio_final <= ALL(
			  SELECT precio_final
			  FROM operacion o2 JOIN inmueble i2 USING(id_inmueble)
				JOIN tipo t2 ON(tipo_inmueble=id_tipo)
			  WHERE t2.nombre ILIKE 'casa'
				AND i2.tipo_operacion ILIKE 'alquiler'
				AND EXTRACT(MONTH FROM o1.fecha_operacion) = EXTRACT(MONTH FROM o2.fecha_operacion)
  							)
ORDER BY EXTRACT(MONTH FROM o1.fecha_operacion);


