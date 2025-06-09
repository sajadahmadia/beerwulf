{{ config(
    schema='marts',
    materialized='table'
) }}


WITH nation_revenue AS (
SELECT 
    c.nation_name,
    SUM(o.total_revenue) as total_revenue
FROM {{ref('fct_orders')}} o
INNER JOIN {{ref('dim_customer')}} c ON o.customer_key = c.customer_key
GROUP BY c.nation_name
)
SELECT 
    nation_name,
    total_revenue
FROM nation_revenue
ORDER BY total_revenue ASC
LIMIT 3