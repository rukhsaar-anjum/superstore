{{
    config(
        materialized = "table"
    )
}}

SELECT
    orders.order_id,
    order_date,
    sales,
    quantity,
    profit,
    discount,
    returned as is_returned
FROM analytics.superstore.orders
LEFT JOIN analytics.superstore.returns
    ON orders.order_id = returns.order_id