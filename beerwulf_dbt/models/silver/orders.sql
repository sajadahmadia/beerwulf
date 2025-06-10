
SELECT DISTINCT
    order_key,
    customer_key,
    order_status,
    total_price,
    order_date,
    -- year and month columns for partitioning in the future if needed
    EXTRACT(YEAR FROM order_date) AS order_year,
    EXTRACT(MONTH FROM order_date) AS order_month,
    EXTRACT(QUARTER FROM order_date) AS order_quarter,
    -- considering fiscal year is from 1 july, a new column
    CASE 
        WHEN EXTRACT(MONTH FROM order_date) >= 7 
        THEN EXTRACT(YEAR FROM order_date)
        ELSE EXTRACT(YEAR FROM order_date) - 1
    END AS fiscal_year,
    CAST(SPLIT_PART(order_priority,'-',1) AS INTEGER) AS priority_code,
    SPLIT_PART(order_priority,'-',2) AS priority_label,
    clerk,
    ship_priority,
    comment
FROM {{ ref('src_orders') }}
WHERE total_price > 0  -- row-wise cleaning