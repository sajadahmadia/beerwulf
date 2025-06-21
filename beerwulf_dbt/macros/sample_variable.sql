{% macro learn_variables() %}

    {{ log("hello dbt variable! " + var("user_name", "no user name is set") + "!", info = True)}}

{% endmacro %}