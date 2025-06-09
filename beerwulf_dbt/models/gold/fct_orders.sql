{{ config(
    schema='gold',
    materialized='table',
    indexes=[
        {'columns': ['order_key'], 'unique': True},
        {'columns': ['customer_key']},
        {'columns': ['date_key']},
        {'columns': ['order_status']}
    ]
) }}

SELECT 
    o.order_key,
    o.customer_key,
    CAST(TO_CHAR(o.order_date, 'YYYYMMDD') AS INTEGER) AS date_key,
    o.total_price,
    o.order_status,
    o.priority_code,
    o.priority_label,
    o.clerk,
    o.ship_priority,
    COUNT(l.line_number) AS line_count,
    COUNT(DISTINCT l.part_key) AS unique_parts_count,
    COUNT(DISTINCT l.supplier_key) AS unique_suppliers_count,
    SUM(l.quantity) AS total_quantity,
    SUM(l.extended_price) AS total_extended_price,
    SUM(l.discount_amount) AS total_discount_amount,
    SUM(l.revenue) AS total_revenue,
    SUM(l.tax_amount) AS total_tax_amount,
    ROUND(AVG(l.discount),2) AS avg_discount_rate,
    MAX(l.days_to_deliver) AS max_delivery_days,
    MIN(l.days_to_deliver) AS min_delivery_days
FROM {{ ref('orders') }} o
LEFT JOIN {{ ref('lineitem') }} l ON o.order_key = l.order_key
GROUP BY 
    o.order_key,
    o.customer_key,
    o.order_date,
    o.total_price,
    o.order_status,
    o.priority_code,
    o.priority_label,
    o.clerk,
    o.ship_priority