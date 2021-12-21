--Ejercicio 1
WITH sub_jefe AS(SELECT e.id_empleado "sub_jefe"
FROM empleado e LEFT JOIN empleado j ON(e.jefe_id=j.id_empleado)
WHERE j.jefe_id IN(
	SELECT id_empleado
	FROM empleado
	WHERE jefe_id IS NULL
					)
  AND e.id_empleado IN (
	  SELECT jefe_id
	  FROM empleado
	  WHERE jefe_id IS NOT NULL
  						)
), empleados_por_jefe AS(
	SELECT jefe_id, id_empleado
	FROM empleado JOIN sub_jefe ON(jefe_id=sub_jefe.sub_jefe)
	GROUP BY jefe_id, id_empleado
	ORDER BY jefe_id
), suma AS(
	SELECT epj.jefe_id "id_jefe", SUM(precio_total) "suma"
	FROM venta JOIN empleado USING(id_empleado)
			JOIN empleados_por_jefe epj USING(id_empleado)
	GROUP BY epj.jefe_id
)
SELECT id_jefe, nombre, apellido1, apellido2, suma.suma, (suma.suma/(SELECT SUM(precio_total) FROM venta) * 100)
FROM suma JOIN empleado ON(id_jefe=id_empleado);
						

--Ejercicio 2
WITH años AS(SELECT id_empleado, (2021-EXTRACT(year FROM fecha_alta)::numeric) "años"
FROM empleado
), suma_por_año AS(
SELECT id_empleado, EXTRACT(year FROM fecha)::numeric, SUM(precio_total) "suma"
FROM venta
GROUP BY id_empleado, EXTRACT(year FROM fecha)::numeric
ORDER BY id_empleado, EXTRACT(year FROM fecha)::numeric
)
SELECT id_empleado, AVG(suma)
FROM suma_por_año
GROUP BY id_empleado;


--Ejercicio 3
WITH ventas_totales AS(
	SELECT COUNT(*)
	FROM venta
), ventas_por_empleado AS(
	SELECT id_empleado, COUNT(*) "ventas"
	FROM venta
	GROUP BY id_empleado
	ORDER BY id_empleado
), dias_trabajados AS(
	SELECT id_empleado, (CURRENT_DATE)-fecha_alta "dias"
	FROM empleado
), media_diaria AS(
	SELECT id_empleado, ((SELECT ventas
						 FROM ventas_por_empleado v
						 WHERE e1.id_empleado = v.id_empleado) / (SELECT dias
																 FROM dias_trabajados d1
																 WHERE e1.id_empleado = d1.id_empleado)) "media"
	FROM empleado e1
), media_empleados AS(
	SELECT AVG(media) "media_total"
	FROM media_diaria
)
SELECT nombre, apellido1, apellido2, media, (ventas/(SELECT *
													FROM ventas_totales))*100, (SELECT media_total
																			   FROM media_empleados)
FROM empleado JOIN media_diaria USING(id_empleado)
		JOIN ventas_por_empleado USING(id_empleado);
		

--Ejercicio 4
SELECT DISTINCT nombre, apellido1, apellido2
FROM empleado JOIN venta USING(id_empleado)
WHERE (EXTRACT(year FROM CURRENT_DATE)::numeric - EXTRACT(year FROM fecha_alta)::numeric) > 6
  AND id_empleado NOT IN (
	  SELECT DISTINCT id_empleado
	  FROM venta JOIN producto USING(id)
	  WHERE nombre ILIKE 'Buey Mishi Kobe'
  );