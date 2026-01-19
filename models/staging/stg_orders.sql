{{ config(
    materialized='view',
    pre_hook="
      insert into DBT_DB.DBT_SAGAR.DBT_AUDIT_LOG
      values ('stg_orders', 'STARTED', current_timestamp)
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

{{ config(
    materialized='view',
    post_hook="
      insert into DBT_DB.DBT_SAGAR.DBT_AUDIT_LOG
      select 'stg_orders', 'COMPLETED', count(*), current_timestamp
      from {{ this }}
    "
) }}
