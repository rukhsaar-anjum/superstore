with sales as (
    select
        extract(year from sales_fact.order_date) as order_year,
        date_trunc('month', sales_fact.order_date) as order_month,
        products_dim.category as product_category,
        sum(sales_fact.sales) as total_sales,
        sum(case when sales_fact.is_returned then sales_fact.quantity end) as total_returned
    from {{ ref('sales_fact')}}
    left join {{ ref("products_dim")}} on sales_fact.product_id = products_dim.product_id
 --   left join {{ ref("customers_dim")}} on sales_fact.customer_id = customers_dim.customer_id
    group by order_year, order_month, product_category
--    order by order_year, order_month
)

select
    order_month,
    product_category,
    total_sales,
    total_returned,
 --   (total_profit/total_sales)*100 as profit_margin,
    lag(total_sales) over (order by order_month) as previous_month_sales,
    lag(total_sales) over (order by product_category) as previous_category_sales,
    total_sales - previous_month_sales as month_on_month_change,
    previous_category_sales - total_sales as sales_growth
from sales