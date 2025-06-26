{{
    config(
        materialized= 'incremental',
        unique_key = 'nation_key',
        incremental_strategy='merge'
    )
}}

SELECT 
    nation_key,
    name,
    region_key,
    comment,
    current_timestamp as updated_at
FROM {{ ref('src_nation') }}
{% if is_incremental() %}
    WHERE updated_at > (SELECT MAX(updated_at) FROM {{ this }})
{% endif %}