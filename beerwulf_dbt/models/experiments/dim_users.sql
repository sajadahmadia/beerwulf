{{config
    (
        schema='users',
        materialized='table'
    )
}}


select user_id,
    max(platform) platform,
    current_timestamp as updated_at
from {{ref('user_events_mock_enriched')}}
group by user_id