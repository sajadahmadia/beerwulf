{{config
    (
        schema='experiments',
        materialized='table'
    )
}}


select ship_mode,
    {{calculate_average('extended_price')}}
from {{ref('lineitem')}}
group by ship_mode