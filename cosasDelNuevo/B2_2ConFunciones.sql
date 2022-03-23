CREATE OR REPLACE FUNCTION e02_1(min numeric, max numeric)
RETURNS table (
	cantidad numeric,
	employee_id numeric
) AS
$$
	SELECT COUNT(*) "numero", employee_id
	FROM orders
	GROUP BY employee_id
	HAVING COUNT(*) >= $1 AND COUNT(*) <= $2
$$
LANGUAGE sql;

SELECT *
FROM e02_1(100, 150);






CREATE OR REPLACE FUNCTION e02_2(id_customer text)
RETURNS numeric AS
$$
	SELECT COUNT(*) "numero"
	FROM orders
	WHERE customer_id = $1
	GROUP BY customer_id
$$
LANGUAGE sql;

SELECT *
FROM e02_2('TOMSP');

SELECT * FROM orders;






