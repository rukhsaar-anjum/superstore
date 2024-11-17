{{
    config(
        materialized = "table"
    )
}}

SELECT
    order_id,
    order_date,
    sales,
    quantity,
    profit
FROM analytics.superstore.orders