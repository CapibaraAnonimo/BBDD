SELECT department_name, MAX(salary)
FROM employees JOIN departments USING(department_id)
GROUP BY department_name;


SELECT department_name, MIN(salary)
FROM employees JOIN departments USING(department_id)
GROUP BY department_name
HAVING MIN(salary) < 5000;