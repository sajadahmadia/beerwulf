{{config
    (
        schema='users',
        materialized='table'
    )
}}


select user_id,
    max(platform) platform,
    current_timestamp as updated_at
from {{source('seeds','user_events_mock_enriched')}}
group by user_id