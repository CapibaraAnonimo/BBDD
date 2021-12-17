SELECT provincia, comprador.nombre, precio_final, fecha_operacion, t1.nombre --No se que es la cuantía
FROM operacion o1 JOIN inmueble i1 USING(id_inmueble)
		JOIN comprador USING(id_cliente)
		JOIN tipo t1 ON(i1.tipo_inmueble=t1.id_tipo)
WHERE precio_final >= ALL(
	SELECT precio_final
	FROM operacion o2 JOIN inmueble i2 USING(id_inmueble)
			JOIN tipo t2 ON(i2.tipo_inmueble=t2.id_tipo)
	WHERE i1.provincia = i2.provincia
							)
ORDER BY provincia;

--Correccion
SELECT i1.provincia, comprador
FROM inmueble i1 JOIN operacion USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
		JOIN comprador USING(id_cliente)
WHERE tipo.nombre = 'Piso'
  AND tipo_operacion = 'Venta'
  AND precio_final >= ALL(
	  SELECT precio_final
	  FROM inmueble i2 JOIN operacion USING(id_inmueble)
			JOIN tipo ON(tipo_inmueble=id_tipo)
	  WHERE tipo.nombre = 'Piso'
	    AND tipo_operacion = 'Venta'
	    AND i1.provincia = i2.provincia
  							);




SELECT provincia, comprador.nombre, precio_final, fecha_operacion, t1.nombre --No se que es la cuantía
FROM operacion o1 JOIN inmueble i1 USING(id_inmueble)
		JOIN comprador USING(id_cliente)
		JOIN tipo t1 ON(i1.tipo_inmueble=t1.id_tipo)
WHERE precio_final <= ALL(
	SELECT precio_final
	FROM operacion o2 JOIN inmueble i2 USING(id_inmueble)
			JOIN tipo t2 ON(i2.tipo_inmueble=t2.id_tipo)
	WHERE i1.provincia = i2.provincia
	  AND EXTRACT(MONTH FROM o1.fecha_operacion) = EXTRACT(MONTH FROM o2.fecha_operacion)
							)
ORDER BY EXTRACT(MONTH FROM o1.fecha_operacion);


--Correccion
SELECT *
FROM inmueble i1 JOIN operacion o1 USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE tipo_operacion = 'Alquiler'
  AND precio_final <= ALL (
	  SELECT precio_final
	  FROM inmueble i2 JOIN operacion o2 USING(id_inmueble)
	  		JOIN tipo ON(tipo_inmueble=id_tipo)
	  WHERE tipo_operacion = 'Alquiler'
	    AND i1.provincia = i2.provincia
	  	AND EXTRACT(MONTH FROM o1.fecha_operacion) = EXTRACT(MONTH FROM o2.fecha_operacion)
  							)