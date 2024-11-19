with
    sales_and_returns as (
        select
            date_trunc('month', order_date) as order_month,
            category as product_category,
            sum(sales) as total_sales,
            sum(
                case when sales_fact.is_returned then sales_fact.quantity end
            ) as total_returned
        from {{ ref("sales_fact") }} sales_fact
        left join
            {{ ref("products_dim") }} products_dim
            on sales_fact.product_id = products_dim.product_id
        group by order_month, product_category
    )

select
    order_month,
    product_category,
    total_sales,
    total_returned
from sales_and_returns