{% macro learn_logging() %}
    {{ log("called logging here", info = True)}}
{% endmacro %}