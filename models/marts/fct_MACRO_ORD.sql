{{ config(
    materialized='table',

    pre_hook="
      delete from DBT_DB.DBT_SAGAR.DBT_AUDIT_LOG
      where model_name = 'fct_MACRO_ORD'
    ",

    post_hook="
      insert into DBT_DB.DBT_SAGAR.DBT_AUDIT_LOG
      select
        'fct_MACRO_ORD',
        'COMPLETED',
        count(*),
        current_timestamp
      from {{ this }}
    "
) }}

select
    o.order_id,
    o.customer_id,
    coalesce(c.first_name || ' ' || c.last_name, 'Unknown') as customer_name,
    o.order_date,
    o.status,
    o.total_amount,
    o.updated_at
from {{ ref('stg_orders') }} o
left join {{ ref('stg_customers') }} c
  on o.customer_id = c.customer_id
