with
    sales as (
        select
            extract(year from sales_fact.order_date) as order_year,
            date_trunc('month', sales_fact.order_date) as order_month,
            products_dim.category as product_category,
            sum(sales_fact.sales) as total_sales
        from {{ ref("sales_fact") }}
        left join
            {{ ref("products_dim") }} on sales_fact.product_id = products_dim.product_id
        where order_year = 2019
        group by order_year, order_month, product_category

),

previous_sales as (
    select
        order_month,
        product_category,
        total_sales,
        lag(total_sales) over (order by product_category, order_month) as previous_month_category_sale
    from sales
)

select
    order_month,
    product_category,
    (total_sales - previous_month_category_sale)/NULLIF(previous_month_category_sale, 0) * 100 as sales_growth_pct
from previous_sales