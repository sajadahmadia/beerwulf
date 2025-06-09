{{ config(
    schema='marts',
    materialized='table'
) }}


SELECT 
    c.customer_key,
    c.customer_name,
    SUM(o.total_revenue) as total_revenue,
    SUM(o.total_quantity) as total_line_item_quantity,
    COUNT(o.order_key) as total_order_count
FROM {{ref('fct_orders')}} o
INNER JOIN {{ref('dim_customer')}} c ON o.customer_key = c.customer_key
GROUP BY c.customer_key, c.customer_name
ORDER BY total_revenue DESC
LIMIT 20