{{ config(
    schema='marts',
    materialized='table'
) }}

SELECT 
    d.year,
    d.month,
    d.month_name,
    SUM(o.total_revenue) as monthly_revenue,
    COUNT(DISTINCT o.order_key) as order_count
FROM {{ref('fct_orders')}} o
INNER JOIN {{ref('dim_date')}} d ON o.date_key = d.date_key
GROUP by d.year, d.month, d.month_name
ORDER BY monthly_revenue DESC
LIMIT 5