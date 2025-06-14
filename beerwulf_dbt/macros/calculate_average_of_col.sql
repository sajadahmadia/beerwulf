{% macro calculate_average(column_name) %}
AVG({{column_name}})
{% endmacro %}