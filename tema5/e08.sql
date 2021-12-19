--Ejercicio 1
SELECT AVG(precio_final), provincia, v1.nombre
FROM operacion o1 JOIN vendedor v1 USING(id_vendedor)
		JOIN inmueble USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE tipo.nombre IN ('Piso', 'Casa')
GROUP BY id_vendedor, v1.nombre, provincia;


--Ejercicio 2
SELECT SUM(precio_final)
FROM operacion JOIN inmueble i1 USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE nombre ILIKE 'local'
  AND precio > (
	  			SELECT superficie*(
									SELECT AVG(precio/superficie)
									FROM inmueble i3 JOIN tipo ON(tipo_inmueble=id_tipo)
									WHERE i2.provincia = i3.provincia
									  AND nombre ILIKE 'local'
									)
	  			FROM inmueble i2 JOIN tipo ON(tipo_inmueble=id_tipo)
	  			WHERE i1.id_inmueble = i2.id_inmueble
	  			  AND nombre ILIKE 'local'
  				)
GROUP BY provincia;


--Ejercicio 3
WITH ventas AS (SELECT provincia, COUNT(*) "suma"
FROM operacion JOIN inmueble USING(id_inmueble)
WHERE tipo_operacion ILIKE 'venta'
GROUP BY provincia, TO_CHAR(fecha_operacion, 'ID'))

SELECT AVG(ventas.suma)
FROM ventas
GROUP BY provincia;


--Ejercicio 4
SELECT t1.nombre, comprador.nombre, provincia, fecha_operacion, precio_final
FROM operacion JOIN inmueble i1 USING(id_inmueble)
		JOIN tipo t1 ON(tipo_inmueble=id_tipo)
		JOIN comprador USING(id_cliente)
WHERE tipo_operacion ILIKE 'venta'
  AND precio_final <= ALL (
							SELECT precio_final
							FROM operacion JOIN inmueble i1 USING(id_inmueble)
									JOIN tipo t2 ON(tipo_inmueble=id_tipo)
							WHERE t1.nombre = t2.nombre
	  						  AND tipo_operacion ILIKE 'venta'
							);
							

--Ejercicio 5
SELECT id_cliente
FROM operacion JOIN inmueble USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE provincia ILIKE 'Sevilla'
  AND tipo.nombre ILIKE 'Piso'
  AND tipo_operacion ILIKE 'venta'
  AND id_cliente NOT IN(
	  					SELECT id_cliente
	  					FROM operacion
	  					WHERE TO_CHAR(fecha_operacion, 'ID') NOT IN ('6', '7')
	  					  AND tipo_operacion ILIKE 'venta'
  						);


--Ejercicio 6
WITH cantidadxdia AS (
	SELECT SUM(DISTINCT id_inmueble) "cant"
	FROM operacion JOIN vendedor USING(id_vendedor)
			JOIN inmueble USING(id_inmueble)
	WHERE tipo_operacion ILIKE 'Venta'
	  AND TO_CHAR(fecha_operacion, 'ID') NOT IN('7')
	GROUP BY TO_CHAR(fecha_operacion, 'ID')
), cantidad_vendedor_dia AS(
	SELECT id_vendedor, SUM(DISTINCT id_inmueble) "ventas"
	FROM operacion JOIN vendedor USING(id_vendedor)
			JOIN inmueble USING(id_inmueble)
	WHERE tipo_operacion ILIKE 'Venta'
	  AND TO_CHAR(fecha_operacion, 'ID') NOT IN('7')
	GROUP BY TO_CHAR(fecha_operacion, 'ID'), id_vendedor
), porcentaje AS(
	SELECT id_vendedor, (cantidad_vendedor_dia.ventas/(	SELECT SUM(DISTINCT id_inmueble) "cant"
														FROM operacion JOIN vendedor USING(id_vendedor)
																JOIN inmueble USING(id_inmueble)
														WHERE tipo_operacion ILIKE 'Venta'
	  													  AND TO_CHAR(fecha_operacion, 'ID') NOT IN('7')
														GROUP BY TO_CHAR(fecha_operacion, 'ID'))) "porc"
	FROM cantidad_vendedor_dia 
)
SELECT vendedor.nombre, TO_CHAR(fecha_operacion, 'ID'), porcentaje.porc
FROM operacion JOIN vendedor USING(id_vendedor)
		JOIN porcentaje USING(id_vendedor)
GROUP BY TO_CHAR(fecha_operacion, 'ID'), vendedor.nombre, porcentaje.porc;