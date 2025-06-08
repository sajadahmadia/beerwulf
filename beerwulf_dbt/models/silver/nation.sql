{{ config(
    schema='silver'
) }}

SELECT 
    nation_key,
    name,
    region_key,
    comment
FROM {{ ref('src_nation') }}