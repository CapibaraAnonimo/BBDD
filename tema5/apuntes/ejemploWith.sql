WITH temp_media AS (
	SELECT AVG(temperatura_maxima) AS "media"
	FROM climatologia
	WHERE fecha::text = '2019-12-15'
)
SELECT*
FROM climatologia
WHERE fecha::text = '2019-12-15'
  AND temperatura_maxima > (
	  SELECT media
	  From temp_media
  							)