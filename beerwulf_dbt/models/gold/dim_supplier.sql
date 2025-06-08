{{ config(
    schema='gold',
    materialized='table'
)
}}

SELECT s.supplier_key,
    s.name AS supplier_name,
    s.address AS supplier_address,
    s.phone AS supplier_phoene,
    s.account_balance AS supplier_account_balance,
    n.name AS supplier_nation_name,
    r.name AS supplier_region_nam,
    s.comment
FROM {{ ref('supplier') }} s
LEFT JOIN {{ ref('nation') }} n ON s.nation_key = n.nation_key
LEFT JOIN {{ ref('region') }} r ON n.region_key = r.region_key