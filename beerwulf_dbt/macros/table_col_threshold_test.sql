{% test col_max_threshold(model, column_name, threshold)%}
select *
from {{model}}
where {{column_name}} >= {{threshold}}
{% endtest %}
