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





CREATE OR REPLACE FUNCTION e02_5(cliente text)
RETURNS TABLE(
	transportista numeric,
	customer text
) AS
$$
	SELECT DISTINCT(shipper_id) "id", customer_id "customer_id"
	FROM shippers JOIN orders ON(shipper_id=ship_via)
		JOIN customers USING(customer_id)
	WHERE customer_id = $1
$$
LANGUAGE sql


with cliente1 AS(
	SELECT DISTINCT(customer)
	FROM orders o JOIN e02_5(customer_id) ON(customer_id = customer)
	WHERE 1 = (SELECT COUNT(transportista) FROM e02_5(customer_id))
)
SELECT company_name
FROM cliente1 JOIN customers ON(customer = customer_id)
WHERE 2 = ALL(SELECT transportista FROM e02_5(customer))



/*6.Queremos saber cual es el proveedor que ha proporcionado ,en promedio, más productos que el proveedor
que en promedio ha proporcionado menos productos*/

CREATE OR REPLACE FUNCTION promedioPromediadoDePromediosProvistos(id_proveedor numeric)
RETURNS TABLE(
	promedio numeric,
	nombre text
)
AS
$$
	SELECT AVG(quantity), company_name
	FROM order_details JOIN products USING(product_id)
		JOIN suppliers USING(supplier_id)
	GROUP BY company_name
$$
LANGUAGE 'sql'

SELECT nombre
FROM suppliers JOIN promedioPromediadoDePromediosProvistos(supplier_id) ON(company_name = nombre)
ORDER BY promedio
OFFSET 1
LIMIT 1;



/*7.Para tener control sobre la tendencia de provisionamiento (en cuanto a unidades se refiere) de los proveedores y 
poder descartar aquellos que no son aptos, hemos de tener un listado de los que si lo son. Se considera que un 
proveedor es apto si el promedio de unidades que ha proporcionado es superior al promedio total de unidades vendidas*/


CREATE OR REPLACE FUNCTION 









