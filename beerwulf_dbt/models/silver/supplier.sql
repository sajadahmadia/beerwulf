{{ config(
    schema='silver'
) }}

SELECT 
    supplier_key,
    name,
    address,
    nation_key,
    phone,
    acct_bal AS account_balance,
    comment
FROM {{ ref('src_supplier') }}