{% test col_max_threshold(model, column_name)%}
select *
from {{model}}
where {{column_name}} >= 2
{% endtest %}
