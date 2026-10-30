-- ============================================================
-- Phase 3: Data Cleaning & Integrity Validation
-- ============================================================

-- 1. Inspect Order Status Distribution
-- Objective: Understand fulfillment stages and identify realized revenue.
SELECT 
    status,
    COUNT(1) AS total_items,
    ROUND(COUNT(1) * 100.0 / SUM(COUNT(1)) OVER (), 2) AS percentage
FROM `bigquery-public-data.thelook_ecommerce.order_items`
GROUP BY status
ORDER BY total_items DESC;

-- 2. Check for Missing Values (NULL Check)
-- Objective: Verify primary keys and financial metrics completeness.
-- Result: 0 nulls detected across all core keys.
SELECT 
    COUNTIF(id IS NULL) AS null_item_ids,
    COUNTIF(order_id IS NULL) AS null_order_ids,
    COUNTIF(product_id IS NULL) AS null_product_ids,
    COUNTIF(sale_price IS NULL) AS null_sale_prices
FROM `bigquery-public-data.thelook_ecommerce.order_items`;

-- 3. Check for Anomalies (Cost vs Sale Price)
-- Objective: Ensure no negative margins or corrupted transaction records.
-- Result: No negative prices or below-cost records found.
SELECT 
    oi.id AS order_item_id,
    oi.product_id,
    p.cost,
    oi.sale_price,
    (oi.sale_price - p.cost) AS gross_profit
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p 
    ON oi.product_id = p.id
WHERE oi.sale_price <= 0 OR oi.sale_price < p.cost
LIMIT 10;