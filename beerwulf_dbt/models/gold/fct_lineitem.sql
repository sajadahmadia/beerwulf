{{ config(
    schema='gold',
    materialized='table',
    indexes=[
        {'columns': ['order_key', 'line_number'], 'unique': True},
        {'columns': ['part_key']},
        {'columns': ['supplier_key']},
        {'columns': ['customer_key']},
        {'columns': ['order_date_key']}
    ]
) }}

SELECT 
    {{ dbt_utils.generate_surrogate_key(['l.order_key', 'l.line_number']) }} AS lineitem_key,
    l.order_key,
    l.line_number,
    o.customer_key, 
    l.part_key,
    l.supplier_key,
    CAST(TO_CHAR(o.order_date, 'YYYYMMDD') AS INTEGER) AS order_date_key,
    CAST(TO_CHAR(l.ship_date, 'YYYYMMDD') AS INTEGER) AS ship_date_key,
    CAST(TO_CHAR(l.commit_date, 'YYYYMMDD') AS INTEGER) AS commit_date_key,
    CAST(TO_CHAR(l.receipt_date, 'YYYYMMDD') AS INTEGER) AS receipt_date_key,
    l.quantity,
    l.extended_price,
    l.discount,
    l.discount_amount,
    l.revenue,
    l.tax,
    l.tax_amount,
    l.total_amount,
    l.return_flag,
    l.line_status,
    l.ship_instruct,
    l.ship_mode,
    l.days_to_deliver
FROM {{ ref('lineitem') }} l
INNER JOIN {{ ref('orders') }} o ON l.order_key = o.order_key