--Sin usar group by decir el nombre de la provincia y el numero de estaciones
SELECT Distinct provincia, 
	(SELECT COUNT(estacion)
	FROM climatologia c2
	WHERE c1.provincia = c2.provincia
	  AND fecha::text = '2019-12-15') "cantidad"
FROM climatologia c1
WHERE fecha::text = '2019-12-15'
ORDER BY cantidad DESC;


SELECT provincia, estacion, temperatura_maxima, 
	(SELECT ROUND(AVG(temperatura_maxima), 2)
	FROM climatologia c2
	WHERE fecha::text = '2019-12-15'
	  AND c1.provincia = c2.provincia)
FROM climatologia c1
WHERE fecha::text = '2019-12-15'