SELECT category_name, product_name, ROUND(SUM(order_details.unit_price*quantity*0.25)::numeric, 2)
FROM categories JOIN products USING(category_id)
		JOIN order_details USING(product_id)
WHERE product_name LIKE 'P%' OR product_name LIKE '%h%'
GROUP BY category_name, product_name