{{ config(
    schema='silver'
) }}

SELECT DISTINCT
    nation_key,
    name,
    region_key,
    comment
FROM {{ ref('src_nation') }}