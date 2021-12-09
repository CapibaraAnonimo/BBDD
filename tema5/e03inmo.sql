SELECT comprador.nombre
FROM comprador JOIN operacion USING(id_cliente)
		JOIN inmueble USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE provincia ILIKE 'Almería'
  AND precio_final < (
	  SELECT AVG(precio)
	  FROM inmueble JOIN tipo ON(tipo_inmueble=id_tipo)
	  WHERE tipo.nombre ILIKE 'Casa'
  				)
  AND tipo.nombre ILIKE 'Casa';


SELECT vendedor.nombre
FROM vendedor JOIN operacion USING(id_vendedor)
		JOIN inmueble USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
WHERE id_vendedor NOT IN(
	SELECT DISTINCT id_vendedor
	FROM vendedor JOIN operacion USING(id_vendedor)
		JOIN inmueble USING(id_inmueble)
		JOIN tipo ON(tipo_inmueble=id_tipo)
	WHERE tipo.nombre NOT ILIKE 'Parking'
						);