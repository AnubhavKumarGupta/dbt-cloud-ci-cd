{{ config(materialized="table") }}

select
    o.customer_id,
    coalesce(c.first_name, '') || ' ' || coalesce(c.last_name, '') as customer_name,
    count(o.order_id) as order_count,
    sum(o.total_amount) as total_revenue
from {{ ref("stg_orders1") }} o
join {{ ref("stg_customers1") }} c on o.customer_id = c.customer_id
group by o.customer_id, c.first_name, c.last_name

-- this is the first changes i'm making. 