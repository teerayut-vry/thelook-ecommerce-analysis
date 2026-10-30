---ROCCC Verification Queries
SELECT 
    'Orders' AS entity,
    MIN(created_at) AS earliest_record,
    MAX(created_at) AS latest_record,
    COUNT(1) AS total_rows,
    COUNT(DISTINCT order_id) AS distinct_keys
FROM `bigquery-public-data.thelook_ecommerce.orders`

UNION ALL

SELECT 
    'Inventory Items' AS entity,
    MIN(created_at) AS earliest_record,
    MAX(created_at) AS latest_record,
    COUNT(1) AS total_rows,
    COUNT(DISTINCT id) AS distinct_keys
FROM `bigquery-public-data.thelook_ecommerce.inventory_items`;