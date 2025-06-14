{{
    config(
        schema='experiments',
        materialized='view'
    )
}}
select *
from {{ref('lineitem')}}
{{filter_by_cat('ship_mode','AIR')}}