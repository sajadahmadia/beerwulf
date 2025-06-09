{{ config(
    schema='marts',
    materialized='table'
) }}


WITH top_nations AS (
    SELECT 
        c.nation_name,
        SUM(o.total_revenue) as total_revenue
    FROM {{ref('fct_orders')}} o
    INNER JOIN {{ref('dim_customer')}} c ON o.customer_key = c.customer_key
    GROUP BY c.nation_name
    ORDER BY total_revenue DESC
    LIMIT 3
)

SELECT 
    l.ship_mode AS top_shipment_method,
    COUNT(*) as shipment_count
FROM gold.fct_lineitem l
INNER JOIN gold.dim_customer c ON l.customer_key = c.customer_key
WHERE c.nation_name IN (SELECT nation_name FROM top_nations)
GROUP BY l.ship_mode
ORDER BY shipment_count DESC
LIMIT 1
