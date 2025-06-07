

SELECT CAST(r_regionkey as INTEGER) AS region_key,
    r_name AS name,
    r_comment AS comment
from {{ source('landing_zone','region') }}