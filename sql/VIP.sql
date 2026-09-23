

-- 優良客をよびだすクエリ
WITH purchaseTotal AS (SELECT
o.customer_id,
sum(d.quantity*d.unit_price) AS total
FROM order_details d 
JOIN  orders o
ON d.id=o.id
GROUP BY o.customer_id
)


SELECT 
p.customer_id,
c.first_name,
c.last_name,
p.total
FROM purchaseTotal p
JOIN customers c
ON p.customer_id=c.id
ORDER BY total DESC


