
SELECT CAST(P_PARTKEY AS INTEGER) AS part_key,
    P_NAME AS name,
    P_MFGR AS manufacturer_name,
    P_BRAND AS brand,
    P_TYPE AS type,
    P_SIZE AS size,
    P_CONTAINER AS container,
    P_RETAILPRICE AS retail_price,
    P_COMMENT AS comment
from {{source('landing_zone','part')}}