-- カテゴリーごとの売り上げ数と全体の売り上げに対する割合
SELECT 
p.category,
FLOOR(SUM(d.quantity)) AS totalQuantity,
FLOOR(SUM(d.unit_price*d.quantity)) AS total,
FLOOR(FLOOR(SUM(d.unit_price*d.quantity))/(

select FLOOR(SUM(quantity*unit_price)) AS TotalSales
from order_details
)

*100) AS SalesProportion
FROM products p
JOIN order_details d
ON p.id=d.product_id
GROUP BY p.category
ORDER BY total DESC
