
{{ config(materialized='view') }}


select
    order_id,
    customer_id,
    {{ clean_string('order_date', 'date', default_order_date) }} as order_date,
    {{ clean_string('status', 'string', default_status) }} as status,
    {{ clean_string('total_amount', 'number') }} as total_amount,
    {{ clean_string('updated_at', 'timestamp') }} as updated_at
from {{ source('sf', 'orders') }}
