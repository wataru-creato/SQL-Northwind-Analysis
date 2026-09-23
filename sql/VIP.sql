
-- 優良客をよびだすクエリ
WITH purchaseTotal AS (SELECT
o.customer_id,
FLOOR(sum(d.quantity*d.unit_price)) AS total
FROM order_details d 
JOIN  orders o
ON d.order_id=o.id
GROUP BY o.customer_id 
)


SELECT 
c.first_name,
c.last_name,
p.total,
p.customer_id
FROM purchaseTotal p
JOIN customers c
ON p.customer_id=c.id
ORDER BY total DESC