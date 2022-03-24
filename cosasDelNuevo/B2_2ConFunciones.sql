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
FROM e02_2('HANAR');

SELECT * FROM orders;





CREATE OR REPLACE FUNCTION e02_3(category text)
RETURNS numeric AS
$$
	SELECT count(*)
	FROM order_details JOIN products USING(product_id)
		JOIN categories USING(category_id)
	GROUP BY category_name
	HAVING category_name ILIKE category
$$
LANGUAGE sql;

SELECT * FROM e02_3('Produce');




CREATE OR REPLACE FUNCTION e02_4(producto text)
RETURNS TABLE(
	cantidad numeric,
	producto text,
	category text
) AS
$$
	SELECT ROUND(SUM((o.unit_price * quantity)*0.25)::numeric, 2), product_name, category_name
	FROM order_details o JOIN products USING(product_id)
		JOIN categories USING(category_id)
	GROUP BY product_id, product_name, category_id, category_name
	HAVING product_name ILIKE producto
$$
LANGUAGE sql;


SELECT *
FROM e02_4('Gula Malacca');





CREATE OR REPLACE FUNCTION e02_5()
RETURNS TABLE(
	cliente text
) AS
$$
	SELECT *
	FROM shippers JOIN orders ON(shipper_id=ship_via)
		JOIN customers USING(customer_id)
$$
LANGUAGE sql





