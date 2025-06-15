{{
    config(
        materialized='table',
        schema='experiments'
    )
}}

select {{dbt_utils.generate_surrogate_key(['order_key','customer_key'])}} as order_sk,
*
from {{ref('orders')}}