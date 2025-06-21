{{
    config(
        schema='monitoring'
    )
}}

select schema,
    name,
    alias,
    message,
    round(cast(total_node_runtime as integer),2) total_runtime
from {{ref('fct_dbt__model_executions')}}
order by total_node_runtime desc 
limit 10