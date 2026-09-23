
-- 現在の在庫数が発注点を下回っている商品をリストアップし、対応すべき仕入先を迅速に把握するクエリ
WITH ProductInfo AS (
SELECT
p.id,
p.product_name,
p.supplier_ids,
p.reorder_level AS needQuantity,
SUM(i.quantity) AS nowQuantity,
p.reorder_level-SUM(i.quantity) AS RequiredOrderQuantity
FROM products p
JOIN inventory_transactions i
ON p.id=i.product_id
GROUP BY p.id
)

SELECT 
p.product_name,
s.company,
s.last_name,
s.first_name,
s.job_title,
p.needQuantity,
p.nowQuantity
FROM ProductInfo p
JOIN suppliers s
ON p.supplier_ids=s.id
WHERE p.RequiredOrderQuantity>0


