/*13.Queremos un listado de los empleados y sus edades*/

SELECT first_name, AGE(birth_date)
FROM employees;


/*14.Queremos un listado del numero de empleados contratados cada mes del año*/

SELECT COUNT(*) ,TO_CHAR(hire_date, 'Month'), extract(year FROM hire_date)
FROM employees
GROUP BY TO_CHAR(hire_date, 'Month'), extract(year FROM hire_date), TO_CHAR(hire_date, 'MM')
ORDER BY extract(year FROM hire_date), TO_CHAR(hire_date, 'MM');


/*15.Queremos un listado del promedio de edad de los empleados por region*/

SELECT AVG(AGE(birth_date)), region
FROM employees
GROUP BY REGION;


/*16.Queremos un listado de los pedidos los cuales tardaron en ser enviados menos de 11 días*/

SELECT order_id, AGE(shipped_date, order_date)
FROM orders
WHERE EXTRACT(days FROM AGE(shipped_date, order_date)) < 11 AND EXTRACT(months FROM AGE(shipped_date, order_date)) = 0
ORDER BY AGE(shipped_date, order_date);


/*17.Queremos un listado de los años laborables pendientes por cada empleado para jubilarse, suponiendo que se 
jubilarán pasado los 65 años de edad*/

SELECT first_name, AGE((birth_date + make_interval(65)), now()) "tiempo"
FROM employees
WHERE AGE((birth_date + make_interval(65)), now()) > make_interval(0,0,0,0,0,0,0);


/*18.Queremos un listado de los 5 empleados que más pronto comenzaron a trabajar y que más tiempo lleven trabajando
en la empresa, con la condición que estos sean de los 5 empleados mas rentables de la empresa, aquellos que más ventas
han realizado*/

WITH empezar AS(
	SELECT employee_id 
	FROM employees 
	ORDER BY hire_date 
	LIMIT 5
),
rentar AS(
	SELECT employee_id 
	FROM orders 
	GROUP BY employee_id
	ORDER BY COUNT(employee_id) DESC
	LIMIT 5
)
SELECT first_name
FROM empezar JOIN rentar USING(employee_id)
	JOIN employees USING(employee_id);
	

/*19.Queremos un listado del promedio de días disponibles para entregar un pedido, agrupando por categoria y 
producto*/

SELECT AVG(age(required_date, order_date)), product_name, category_name
FROM orders JOIN order_details USING(order_id)
	JOIN products USING(product_id)
	JOIN categories USING(category_id)
GROUP BY category_name, product_name
ORDER BY category_name, product_name


