{{ config(
    schema='silver'
) }}

SELECT 
    part_key,
    supplier_key,
    avail_qty AS available_quantity,
    supply_cost,
    -- new generated column, 
    avail_qty * supply_cost AS total_supply_value,
    comment
FROM {{ ref('src_partsupp') }}