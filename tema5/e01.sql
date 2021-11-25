SELECT department_name, MAX(salary)
FROM employees JOIN departments USING(department_id)
GROUP BY department_name;


SELECT department_name, MIN(salary)
FROM employees JOIN departments USING(department_id)
GROUP BY department_name
HAVING MIN(salary) < 5000;


SELECT street_address, COUNT(employee_id) AS "numero de empleados"
FROM employees JOIN departments USING(department_id)
	 JOIN locations USING(location_id)
GROUP BY street_address
ORDER BY COUNT(employee_id) DESC;


SELECT street_address
FROM employees JOIN departments USING(department_id)
	 JOIN locations USING(location_id)
GROUP BY street_address
HAVING COUNT(employee_id) = 0
ORDER BY COUNT(employee_id) DESC;


SELECT salary, COUNT(employee_id)
FROM employees
GROUP BY salary
ORDER BY COUNT(employee_id) DESC
LIMIT 1;


SELECT EXTRACT(year FROM hire_date) AS "año de contratación", COUNT(employee_id) AS "número de empleados"
FROM employees
GROUP BY EXTRACT(year FROM hire_date)
ORDER BY EXTRACT(year FROM hire_date);







