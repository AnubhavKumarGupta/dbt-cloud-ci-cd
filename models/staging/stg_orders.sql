select
  ORDER_ID as order_id,
  USER_ID as user_id,
  TIMESTAMP as order_timestamp
from {{ source('instacart', 'orders') }}

