{{ config(
    schema='silver'
) }}

SELECT DISTINCT
    region_key,
    name,
    comment
FROM {{ ref('src_region') }}