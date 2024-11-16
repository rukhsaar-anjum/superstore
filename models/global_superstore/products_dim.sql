{{
    config(
        materialized = "table"
    )
}}

SELECT
    product_id,
    product_name,
    category,
    sub_category
FROM orders