SELECT department_name, MAX(salary)
FROM employees JOIN departments USING(department_id)
GROUP BY department_name