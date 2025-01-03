{{
    config(
        materialized = "table"
    )
}}

WITH base AS (
    SELECT
        customer_id,
        customer_name,
        segment,
        country_or_region,
        city,
        state_or_province,
        postal_code,
        region
    FROM {{source ('superstore','orders')}}
)

SELECT * FROM base