
--here, i added 5 new row-wise calculated columns, and a simple data cleaning in the where clause
SELECT DISTINCT
    order_key,
    part_key,
    supplier_key,
    line_number,
    quantity,
    extended_price,
    discount,
    tax,
    return_flag,
    line_status,
    ship_date,
    commit_date,
    receipt_date,
    ship_instruct,
    ship_mode,
    comment,
    -- 5 new columns
    extended_price * discount AS discount_amount,
    extended_price * (1 - discount) AS revenue,
    extended_price * (1 - discount) * tax AS tax_amount,
    extended_price * (1 - discount) * (1 + tax) AS total_amount,
    receipt_date - ship_date AS days_to_deliver
    
FROM {{ ref('src_lineitem') }}
--here, row-wise cleaning 
WHERE quantity > 0 
and ship_date < receipt_date