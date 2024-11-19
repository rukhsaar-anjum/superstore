with
    sales as (
        select
            extract(year from order_date) as order_year,
            date_trunc('month', order_date) as order_month,
            sum(sales) as total_sales
        from {{ ref("sales_fact") }}
        where order_year = 2019
        group by order_month, order_year

),

previous_sales as (
    select
        order_year,
        order_month,
        total_sales,
        lag(total_sales) over (order by order_month) as previous_month_sales
    from sales
)

select
    order_year,
    order_month,
    total_sales,
    (total_sales - previous_month_sales)/NULLIF(previous_month_sales, 0) * 100 as month_on_month_change_pct
from previous_sales