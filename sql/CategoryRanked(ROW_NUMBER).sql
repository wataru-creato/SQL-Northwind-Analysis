WITH RankedCategory AS (SELECT
ROW_NUMBER()
OVER(PARTITION BY p.category
ORDER BY(unit_price) DESC) AS Ranked,
p.product_name,
d.unit_price,
p.category
FROM products p
JOIN order_details d
ON p.id=d.product_id
)

SELECT *
FROM RankedCategory
WHERE Ranked IN (1,2,3)
-- ORDER BY category, Ranked;