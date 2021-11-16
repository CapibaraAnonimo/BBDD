SELECT DISTINCT company_name, contact_name
FROM customers JOIN orders USING(customer_id);


SELECT COUNT(order_id) AS "Número de pedidos en la decada de los 90"
FROM orders
WHERE required_date BETWEEN date '1990-01-01' AND date '1999-12-30';


SELECT DISTINCT product_name
FROM order_details JOIN products USING(product_id);

SELECT SUM((unit_price*quantity) - (unit_price*quantity*discount))
FROM order_details JOIN orders USING(order_id)
WHERE order_date BETWEEN date '1996-01-01' AND date '1996-12-30';


SELECT contact_name AS "Cliente", first_name AS "Nombre Empleado", last_name AS "Apellido Empleado"
FROM customers JOIN orders USING(customer_id)
	 JOIN employees USING(employee_id)
WHERE required_date - shipped_date < 20;