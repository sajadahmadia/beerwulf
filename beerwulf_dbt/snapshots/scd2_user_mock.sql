{% snapshot dim_users_scd %}

{{
    config(
        target_schema = 'scd_tables',
        unique_key = 'user_id',
        strategy = 'timestamp',
        updated_at = 'updated_at',
        invalidate_hard_deletes = False
    )
}}

select * 
from {{ref('dim_users')}}


{% endsnapshot %}