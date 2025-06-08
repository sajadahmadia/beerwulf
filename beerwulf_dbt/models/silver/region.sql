{{ config(
    schema='silver'
) }}

SELECT 
    region_key,
    name,
    comment
FROM {{ ref('src_region') }}