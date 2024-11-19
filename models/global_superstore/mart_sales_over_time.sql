with
    sales as (
        select
            extract(year from order_date) as order_year,
            date_trunc('month', order_date) as order_month,
            date_trunc('week', order_date) as order_week,
            sum(sales) as total_sales,
            sum(profit) as total_profit
        from {{ ref("sales_fact") }}
        left join
            {{ ref("products_dim") }} on sales_fact.product_id = products_dim.product_id
        left join
            {{ ref("customers_dim") }}
            on sales_fact.customer_id = customers_dim.customer_id
        group by order_year, order_month, order_week
    )

select
    order_year,
    order_month,
    order_week,
    total_sales,
    total_profit,
    (total_profit / total_sales) * 100 as profit_margin
from sales
