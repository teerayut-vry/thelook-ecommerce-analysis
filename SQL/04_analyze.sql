-- 1. Category Profitability & Margin Performance
SELECT 
    p.category,
    COUNT(DISTINCT oi.order_id) AS total_orders,
    ROUND(SUM(oi.sale_price), 2) AS total_revenue,
    ROUND(SUM(oi.sale_price - p.cost), 2) AS total_profit,
    ROUND(SAFE_DIVIDE(SUM(oi.sale_price - p.cost), SUM(oi.sale_price)) * 100, 2) AS profit_margin_pct
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p 
    ON oi.product_id = p.id
WHERE oi.status = 'Complete' 
GROUP BY p.category
ORDER BY total_profit DESC
LIMIT 10;

-- 2. Slow-Moving & Dead Stock Identification (>180 Days)
SELECT 
    p.category,
    COUNT(inv.id) AS unsold_items_count,
    ROUND(AVG(DATE_DIFF(CURRENT_DATE(), DATE(inv.created_at), DAY)), 1) AS avg_days_in_warehouse,
    ROUND(SUM(inv.cost), 2) AS tied_up_cost_usd
FROM `bigquery-public-data.thelook_ecommerce.inventory_items` inv
JOIN `bigquery-public-data.thelook_ecommerce.products` p 
    ON inv.product_id = p.id
WHERE inv.sold_at IS NULL -- In stock product
GROUP BY p.category
HAVING avg_days_in_warehouse > 180
ORDER BY tied_up_cost_usd DESC
LIMIT 10;

-- 3. Order Value Distribution (Basket Size Segmentation)
WITH order_summary AS (
    SELECT 
        order_id,
        SUM(sale_price) AS order_value
    FROM `bigquery-public-data.thelook_ecommerce.order_items`
    WHERE status = 'Complete'
    GROUP BY order_id
)
SELECT 
    CASE 
        WHEN order_value < 50 THEN '1. Low Value (< $50)'
        WHEN order_value BETWEEN 50 AND 100 THEN '2. Mid Value ($50 - $100)'
        WHEN order_value BETWEEN 100 AND 200 THEN '3. High Value ($100 - $200)'
        ELSE '4. Premium (> $200)'
    END AS basket_tier,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(order_value), 2) AS tier_revenue,
    ROUND(COUNT(order_id) * 100.0 / SUM(COUNT(order_id)) OVER (), 2) AS order_percentage
FROM order_summary
GROUP BY basket_tier
ORDER BY basket_tier;
