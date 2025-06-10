{{ config(
    schema='silver'
) }}
--first, we get the percentiles of the account balance
WITH customer_percentiles AS (
    SELECT 
        PERCENTILE_CONT(0.33) WITHIN GROUP (ORDER BY account_balance) AS p33,
        PERCENTILE_CONT(0.67) WITHIN GROUP (ORDER BY account_balance) AS p67
    FROM {{ ref('src_customer') }}
)

SELECT DISTINCT
    c.customer_key,
    c.name,
    c.address,
    c.nation_key,
    c.phone,
    c.account_balance,
    -- segmentation based on percentile and account balance
    CASE 
        WHEN c.account_balance <= cp.p33 THEN 'LOW'
        WHEN c.account_balance <= cp.p67 THEN 'MEDIUM'
        ELSE 'HIGH'
    END AS account_balance_segment,
    c.market_segment,
    c.comment
FROM {{ ref('src_customer') }} c
CROSS JOIN customer_percentiles cp