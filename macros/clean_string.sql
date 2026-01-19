{% macro clean_string(col, dtype, default=None) %}
  {% if dtype == 'string' %}
    coalesce(trim(INITCAP({{ col }})), {{ default if default is not none else "NULL" }})
  {% elif dtype == 'date' %}
    coalesce(cast({{ col }} as date), {{ default if default is not none else "NULL" }})
  {% elif dtype == 'timestamp' %}
    coalesce(cast({{ col }} as timestamp_ntz), {{ default if default is not none else "NULL" }})
  {% elif dtype == 'number' %}
    coalesce({{ col }}, {{ default if default is not none else "NULL" }})
  {% else %}
    {{ col }}
  {% endif %}
{% endmacro %}

