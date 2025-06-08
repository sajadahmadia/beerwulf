{{ config(
    schema='gold',
    materialized='table'
) }}

SELECT c.customer_key,
    c.name AS customer_name,
    c.address AS customer_address,
    c.phone AS customer_phone,
    c.account_balance AS customer_account_balance,
    c.market_segment AS customer_market_segment,
    c.comment,
    n.name AS nation_name,
    r.name AS region_name
FROM {{ ref('customer') }} c
LEFT JOIN {{ ref('nation') }} n ON c.nation_key = n.nation_key
LEFT JOIN {{ ref('region') }} r ON n.region_key = r.region_key