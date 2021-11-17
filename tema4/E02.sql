SELECT first_name, last_name
FROM employees JOIN departments USING(department_id)
WHERE (department_name ILIKE 'IT'
   	  OR department_name ILIKE 'Finance')
  AND (hire_date::text ILIKE '____-04%'
	  OR hire_date::text ILIKE '____-06%');
	  

SELECT e2.first_name, e2.last_name
FROM employees e1 JOIN departments USING(department_id)
		JOIN employees e2 ON(e1.manager_id=e2.employee_id)
WHERE department_name ILIKE 'Administration';


SELECT country_name
FROM departments JOIN locations USING(location_id)
		JOIN countries USING(country_id)
WHERE department_name ILIKE 'Public Relations';


SELECT first_name, last_name
FROM employees JOIN departments USING(department_id)
		JOIN locations USING(location_id)
		JOIN countries USING(country_id)
		JOIN regions USING(region_id)
WHERE region_name ILIKE 'Americas';


SELECT dependents.first_name AS "Nombre Hijo", dependents.last_name AS "Apellido Hijo", 
		employees.first_name AS "Nombre Padre", employees.last_name AS "Apellido Padre"
FROM employees JOIN departments USING(department_id)
		JOIN locations USING(location_id)
		JOIN countries USING(country_id)
		JOIN regions USING(region_id)
		JOIN dependents USING(employee_id)
WHERE region_name ILIKE 'Americas'
ORDER BY country_name ASC;


SELECT e1.first_name, e1.last_name, d1.department_name
FROM departments d1 JOIN employees e1 ON(d1.department_id=e1.department_id)
		JOIN employees e2 ON(e1.manager_id=e2.employee_id)
		JOIN departments d2 ON(e2.department_id=d2.department_id)
WHERE d2.department_name ILIKE 'Executive'
  AND e1.salary > 8000
ORDER BY e1.first_name, e1.last_name;



