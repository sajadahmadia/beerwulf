


SELECT CAST(N_NATIONKEY AS INTEGER) AS nation_key,
    N_NAME AS name,
    CAST(N_REGIONKEY AS INTEGER) AS region_key,
    N_COMMENT AS comment,
    current_timestamp as updated_at
from {{source('landing_zone','nation')}}