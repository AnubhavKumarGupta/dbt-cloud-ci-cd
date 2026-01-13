{% macro clean_string(col) %}
  trim(INITCAP({{ col }}))
{% endmacro %}
