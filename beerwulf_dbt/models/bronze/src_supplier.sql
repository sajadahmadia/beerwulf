
SELECT
  CAST(S_SUPPKEY    AS INTEGER) AS supplier_key,
  S_NAME                          AS name,
  S_ADDRESS                       AS address,
  CAST(S_NATIONKEY AS INTEGER)   AS nation_key,
  S_PHONE                         AS phone,
  CAST(S_ACCTBAL    AS INTEGER)  AS acct_bal,
  S_COMMENT                       AS comment
FROM {{ source('landing_zone','supplier') }}
