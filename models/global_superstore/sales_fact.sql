{{
    config(
        materialized = "table"
    )
}}

WITH base AS (
    SELECT
        orders.order_id,
        to_date(order_date, 'dd-mm-yyyy') as order_date,
        sales,
        quantity,
        profit,
        discount,
        returned as is_returned
    FROM {{source ('superstore','orders')}}
    LEFT JOIN {{source ('superstore','returns')}}
        ON orders.order_id = returns.order_id
)

SELECT * FROM base