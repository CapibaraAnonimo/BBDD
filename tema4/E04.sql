SELECT DISTINCT p1.product_name
FROM orders o1 JOIN shippers s1 ON(o1.ship_via=s1.shipper_id)
     JOIN order_details od1 ON(o1.order_id=od1.order_id)
	 JOIN products p1 ON(od1.product_id=p1.product_id)
WHERE company_name ILIKE 'United Package';


SELECT DISTINCT product_name, category_name
FROM orders JOIN order_details USING(order_id)
	 JOIN products USING(product_id)
	 JOIN categories USING(category_id)
WHERE date_part('month', order_date) = 06;


SELECT company_name
FROM customers;


SELECT employees.first_name, employees.last_name
FROM customers JOIN orders USING(customer_id)
	 JOIN employees USING(employee_id)
WHERE customers.country ILIKE 'Brazil';


SELECT DISTINCT product_name, category_name
FROM employees JOIN orders USING(employee_id)
	 JOIN order_details USING(order_id)
	 JOIN products USING(product_id)
	 JOIN categories USING(category_id)
WHERE first_name ILIKE 'Janet'
  AND last_name ILIKE 'Leverling';
  

SELECT product_name, category_name
FROM categories JOIN products USING(category_id)
	 JOIN order_details USING(product_id)
	 JOIN orders USING(order_id)
	 JOIN employees e1 USING(employee_id)
	 JOIN shippers s1 ON(ship_via=s1.shipper_id)
WHERE date_part('month', order_date) = 07
  AND company_name ILIKE 'United Package'
  AND products.unit_price > 20
ORDER BY product_name;