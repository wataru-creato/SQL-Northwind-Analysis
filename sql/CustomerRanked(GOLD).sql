-- 条件ごとに顧客ごとのランクをまとめる
WITH OrderCustomers AS (SELECT 
c.id,
o.id AS orderId,
c.last_name,
c.first_name
FROM customers c
LEFT JOIN orders o
ON c.id=o.customer_id
GROUP BY c.id,orderId),

TotalPurchase AS (SELECT
oc.id,
oc.last_name,
oc.first_name,
SUM(d.quantity*d.unit_price) AS total
FROM OrderCustomers oc
LEFT JOIN order_details d
ON d.order_id=oc.orderId
GROUP BY 
oc.id,
oc.last_name,
oc.first_name
)

SELECT 
id,
last_name,
first_name,
FLOOR(COALESCE(total, 0))AS total,
CASE
 WHEN total>10000 THEN 'プラチナ'
 WHEN total>=5000 and total<10000 THEN 'ゴールド'
 WHEN total>=1000 and total<5000 THEN 'シルバー'
 ELSE 'ブロンズ'
END AS customerRanked
FROM TotalPurchase