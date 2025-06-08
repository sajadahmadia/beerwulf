{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT 
    part_key,
    name AS part_name,
    manufacturer_name,
    brand AS part_brand,
    type as part_type,
    size as part_size,
    container as part_container,
    retail_price part_retail_price,
    comment part_comment
FROM {{ ref('part') }}