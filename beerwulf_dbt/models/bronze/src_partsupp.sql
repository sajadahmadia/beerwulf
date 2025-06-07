SELECT
  CAST(PS_PARTKEY    AS INTEGER) AS part_key,
  CAST(PS_SUPPKEY    AS INTEGER) AS supplier_key,
  CAST(PS_AVAILQTY   AS INTEGER) AS avail_qty,
  CAST(PS_SUPPLYCOST AS INTEGER) AS supply_cost,
  PS_COMMENT                      AS comment
FROM {{ source('landing_zone','partsupp') }}
