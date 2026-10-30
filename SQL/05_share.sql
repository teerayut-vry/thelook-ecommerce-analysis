--1. Sales Performance View
CREATE OR REPLACE VIEW `pivotal-theory-509509-i0.thelook_analytics.v_sales_performance` AS
SELECT 
    oi.order_id,
    p.category,
    p.name AS product_name,
    oi.sale_price,
    p.cost,
    (oi.sale_price - p.cost) AS profit,
    DATE(oi.created_at) AS order_date
FROM `bigquery-public-data.thelook_ecommerce.order_items` oi
JOIN `bigquery-public-data.thelook_ecommerce.products` p 
    ON oi.product_id = p.id
WHERE oi.status = 'Complete';


--2. Inventory Aging View
CREATE OR REPLACE VIEW `pivotal-theory-509509-i0.thelook_analytics.v_inventory_aging` AS
SELECT 
    p.category,
    p.name AS product_name,
    inv.cost AS unit_cost,
    DATE_DIFF(CURRENT_DATE(), DATE(inv.created_at), DAY) AS days_in_stock
FROM `bigquery-public-data.thelook_ecommerce.inventory_items` inv
JOIN `bigquery-public-data.thelook_ecommerce.products` p 
    ON inv.product_id = p.id
WHERE inv.sold_at IS NULL;
