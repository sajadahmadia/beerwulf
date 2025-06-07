SELECT
  CAST(C_CUSTKEY    AS INTEGER) AS customer_key,
  C_NAME                         AS name,
  C_ADDRESS                      AS address,
  CAST(C_NATIONKEY AS INTEGER)  AS nation_key,
  C_PHONE                        AS phone,
  CAST(C_ACCTBAL    AS INTEGER) AS acct_bal,
  C_MKTSEGMENT                   AS market_segment,
  C_COMMENT                      AS comment
FROM {{ source('landing_zone','customer') }}