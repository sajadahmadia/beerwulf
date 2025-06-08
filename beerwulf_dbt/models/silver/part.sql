{{ config(
    schema='silver'
) }}

SELECT 
    part_key,
    name,
    manufacturer_name,
    brand,
    type,
    size,
    container,
    retail_price,
    comment
FROM {{ ref('src_part') }}