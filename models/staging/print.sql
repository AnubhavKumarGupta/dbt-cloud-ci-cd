-- select * from {{ ref('stg_orders') }}

-- select * from {{ source('dbt_raw','orders') }}


select * from {{ source('dbt_raw','orders') }}
