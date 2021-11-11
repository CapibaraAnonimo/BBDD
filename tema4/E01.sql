SELECT first_name, last_name, email
FROM locations JOIN departments USING(location_id)
		JOIN employees USING(department_id)
		JOIN countries USING(country_id)
WHERE country_name ILIKE('United Kingdom');


SELECT department_name
FROM departments JOIN employees USING(department_id)
WHERE STARTS_WITH (hire_date::text, '1993');


SELECT DISTINCT region_name
FROM regions JOIN countries USING(region_id)
		JOIN locations USING(country_id)
		JOIN departments USING(location_id)
		JOIN employees USING(department_id)
WHERE salary < 10000;

SELECT e1.first_name, e1.last_name
FROM employees e1 JOIN employees e2 ON (e1.employee_id=e2.manager_id)
WHERE (e2.last_name ILIKE 'D%'
	   OR e2.last_name ILIKE 'H%'
	   OR e2.last_name ILIKE 'S%')


