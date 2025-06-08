with cte as (
    select dc.nation_name
    from {{ref('fct_orders')}} o 
    left join {{ref('dim_customer')}} dc on o.customer_key = dc.customer_key 
    group by dc.nation_name
    order by sum(o.total_revenue) desc
    limit 3 
)
select ship_mode
from {{ref('fct_lineitem')}} fl 
inner join cte on cte.