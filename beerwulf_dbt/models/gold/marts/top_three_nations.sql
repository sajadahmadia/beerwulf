

select ds.supplier_nation_name, sum(fl.revenue) nation_total_revenue
from {{ref('fct_lineitem')}} fl 
left join {{ref('dim_supplier')}} ds on fl.supplier_key = ds.supplier_key 
group by ds.supplier_nation_name
order by sum(fl.revenue) asc
