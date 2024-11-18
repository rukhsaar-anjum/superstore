{{
    config(
        materialized = "table"
    )
}}

WITH base AS (
SELECT
    product_id,
    product_name,
    category,
    sub_category
FROM {{source ('superstore','orders')}}
)

SELECT * FROM base