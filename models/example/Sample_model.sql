{{ config(materialized='view') }}

select current_timestamp as created_at
