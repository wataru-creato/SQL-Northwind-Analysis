WITH setOrders AS(
SELECT 
d.product_id,
FLOOR(d.quantity) AS Oquantity,
FLOOR(d.unit_price) AS OunitPrice,
o.order_date
FROM order_details d
JOIN orders o
ON d.order_id=o.id
),

RankedSales AS(
SELECT 
ROW_NUMBER() 
OVER (PARTITION BY DATE_FORMAT(o.order_date,'%Y%m')
ORDER BY FLOOR(SUM(o.Oquantity*o.OunitPrice)) DESC) AS Ranked,
DATE_FORMAT(o.order_date,'%Y%m') AS orderDate,
p.product_name,
(SELECT
FLOOR(SUM(o.Oquantity*o.OunitPrice))
) AS total
FROM setOrders o
JOIN products p
ON o.product_id=p.id
GROUP BY DATE_FORMAT(o.order_date,'%Y%m'),
p.product_name
)

SELECT *
FROM RankedSales
WHERE Ranked IN (1,2,3)