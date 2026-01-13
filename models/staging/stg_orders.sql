{{ config(materialized='view') }}

select
    order_id,
    customer_id,
    order_date,
    {{ clean_string('status') }} as status,
    total_amount,
    updated_at
from {{ source('sf', 'orders') }}
