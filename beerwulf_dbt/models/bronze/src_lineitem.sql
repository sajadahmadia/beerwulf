SELECT
  CAST(L_ORDERKEY    AS INTEGER) AS order_key,
  CAST(L_PARTKEY     AS INTEGER) AS part_key,
  CAST(L_SUPPKEY     AS INTEGER) AS supplier_key,
  CAST(L_LINENUMBER  AS INTEGER) AS line_number,
  CAST(L_QUANTITY    AS INTEGER) AS quantity,
  CAST(L_EXTENDEDPRICE AS INTEGER) AS extended_price,
  CAST(L_DISCOUNT    AS INTEGER) AS discount,
  CAST(L_TAX         AS INTEGER) AS tax,
  L_RETURNFLAG                     AS return_flag,
  L_LINESTATUS                     AS line_status,
  CAST(L_SHIPDATE    AS DATE)    AS ship_date,
  CAST(L_COMMITDATE  AS DATE)    AS commit_date,
  CAST(L_RECEIPTDATE AS DATE)    AS receipt_date,
  L_SHIPINSTRUCT                   AS ship_instruct,
  L_SHIPMODE                       AS ship_mode,
  L_COMMENT                        AS comment
FROM {{ source('landing_zone','lineitem') }}
