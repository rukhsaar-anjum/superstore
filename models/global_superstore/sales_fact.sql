{{ config(materialized="table") }}

with
    base as (
        select
            orders.order_id,
            to_date(order_date, 'dd-mm-yyyy') as order_date,
            product_id,
            customer_id,
            sales,
            quantity,
            profit,
            discount,
            returned as is_returned
        from {{ source("superstore", "orders") }}
        left join
            {{ source("superstore", "returns") }} on orders.order_id = returns.order_id
    )

select *
from base