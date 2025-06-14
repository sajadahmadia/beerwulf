{% macro filter_by_cat(column_name, category)%}
where {{column_name}} = '{{ category }}'
{% endmacro%}