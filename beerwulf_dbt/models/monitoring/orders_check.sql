-- models/marts/fct_orders.sql
{% set min_order_count = var('min_order_count', 1000) %}  -- Make threshold configurable

{% if execute %}
    {% set row_count_query %}
        select count(*) as cnt from {{ ref('orders') }}
        where order_date = '{{ var("process_date") }}'
    {% endset %}
    
    {% set results = run_query(row_count_query) %}
    {% set row_count = results.columns[0].values()[0] %}
    
    {% if row_count < min_order_count %}
        {{ log("⚠️ WARNING: Only " ~ row_count ~ " orders found for " ~ var("process_date") ~ ". Expected minimum: " ~ min_order_count, info=True) }}
    {% else %}
        {{ log("✓ Order count healthy: " ~ row_count ~ " orders for " ~ var("process_date"), info=True) }}
    {% endif %}
{% endif %}

select * from {{ ref('orders') }}
where order_date = '{{ var("process_date") }}'