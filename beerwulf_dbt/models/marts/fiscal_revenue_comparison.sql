{{ config(
    schema='marts',
    materialized='table'
) }}


WITH fiscal_year_revenue AS (
SELECT 
    d.fiscal_year,
    SUM(o.total_revenue) as fs_year_revenue
FROM {{ref('fct_orders')}} o
INNER JOIN {{ref('dim_date')}} d ON o.date_key = d.date_key
GROUP BY d.fiscal_year
),
comparison AS (
    SELECT 
        fiscal_year,
        fs_year_revenue,
        LAG(fs_year_revenue) OVER (ORDER BY fiscal_year) as previous_fs_revenue
    FROM fiscal_year_revenue)
SELECT fiscal_year,
    fs_year_revenue AS current_year_revenue,
    previous_fs_revenue AS previous_year_revenue,
    ROUND(((fs_year_revenue - previous_fs_revenue) / NULLIF(previous_fs_revenue, 0)) * 100, 2) as revenue_growth_pct
FROM comparison
ORDER BY fiscal_year

