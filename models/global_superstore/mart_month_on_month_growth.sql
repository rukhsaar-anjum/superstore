with
    sales as (
        select
            extract(year from sales_fact.order_date) as order_year,
            date_trunc('month', sales_fact.order_date) as order_month,
            products_dim.category as product_category,
            sum(sales_fact.sales) as total_sales,
            sum(
                case when sales_fact.is_returned then sales_fact.quantity end
            ) as total_returned
        from {{ ref("sales_fact") }}
        left join
            {{ ref("products_dim") }} on sales_fact.product_id = products_dim.product_id
        where order_year = 2019
        group by order_year, order_month, product_category

    )

select
    order_month,
    product_category,
    total_sales
    - (lag(total_sales) over (order by order_month)) as month_on_month_change,
    (lag(total_sales) over (order by product_category)) - total_sales as sales_growth
from sales
