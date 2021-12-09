SELECT employee_id, count(order_id)
FROM orders
GROUP BY employee_id
HAVING count(order_id) <= 150 AND count(order_id) >= 100;


SELECT DISTINCT company_name
FROM customers LEFT JOIN orders USING(customer_id)
GROUP BY company_name
HAVING COUNT(order_id) = 0;


SELECT category_name, COUNT(order_id) "cantidad"
FROM  categories JOIN products USING(category_id)
		JOIN order_details USING(product_id)
GROUP BY category_name
ORDER BY cantidad DESC
LIMIT 1;


SELECT category_name, product_name, ROUND(SUM(order_details.unit_price*order_details.quantity*0.25)::numeric, 2)
FROM categories JOIN products USING(category_id)
		JOIN order_details USING(product_id)
GROUP BY category_name, product_name;


SELECT contact_name
FROM shippers JOIN orders ON(shipper_id=ship_via)
		JOIN customers USING(customer_id)
WHERE shippers.company_name ILIKE 'United Package'
GROUP BY contact_name;

SELECT DISTINCT c.company_name
FROM customers c JOIN orders o USING(customer_id)
		JOIN shippers s ON(shipper_id=ship_via)
WHERE c.customer_id








