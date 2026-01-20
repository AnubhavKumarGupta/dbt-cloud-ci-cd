{{ config(
    materialized='view',



    pre_hook="
      insert into DBT_DB.DBT_SAGAR.DBT_AUDIT_LOG
      (model_name, status, row_count, event_time)
      values ('stg_orders', 'STARTED', null, current_timestamp)
    ",

    post_hook="
      insert into DBT_DB.DBT_SAGAR.DBT_AUDIT_LOG
      (model_name, status, row_count, event_time)
      select
        'stg_orders',
        'COMPLETED',
        count(*),
        current_timestamp
      from {{ this }}
    "
) }}

select
    order_id,
    customer_id,
    {{ clean_string('order_date', 'date', var('default_order_date')) }} as order_date,
    {{ clean_string('status', 'string', var('default_status')) }} as status,
    total_amount,
    updated_at
from {{ source('sf', 'orders') }}
