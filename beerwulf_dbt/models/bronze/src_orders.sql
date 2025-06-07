SELECT
  CAST(O_ORDERKEY      AS INTEGER) AS order_key,
  CAST(O_CUSTKEY       AS INTEGER) AS customer_key,
  O_ORDERSTATUS                     AS order_status,
  CAST(O_TOTALPRICE   AS INTEGER)  AS total_price,
  CAST(O_ORDERDATE     AS DATE)    AS order_date,
  O_ORDERPRIORITY                   AS order_priority,
  O_CLERK                           AS clerk,
  CAST(O_SHIPPRIORITY AS INTEGER)  AS ship_priority,
  O_COMMENT                        AS comment
FROM {{ source('landing_zone','orders') }}
