SELECT *
FROM employees
WHERE salary  > (
	SELECT salary "S.K"
	FROM employees
	WHERE first_name || ' ' || last_name = 'Sarah Bell'
) AND salary < (
	SELECT salary "S.K"
	FROM employees
	WHERE first_name || ' ' || last_name = 'Lex De Haan'
);


--Seleccionar el salario que es cobrado a la vez por más personas. Mostrar dicho salario y el número de personas.

SELECT salary, COUNT(employee_id)
FROM employees
GROUP BY salary
HAVING COUNT(employee_id) = (SELECT MAX(valor) 
							 FROM (SELECT COUNT(employee_id) "valor"
								   FROM employees
								   GROUP BY salary
								  ) datos
);






