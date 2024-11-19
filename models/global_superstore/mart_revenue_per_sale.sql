with
    sales as (
        select
            date_trunc('month', order_date) as order_month,
            sum(quantity) as total_sales_count,
            sum(sales) as total_sales_amount
        from {{ ref("sales_fact") }}
        group by order_month
    )
select
    order_month,
    total_sales_amount / nullif(total_sales_count, 0) as avg_revenue_per_sale
from sales
