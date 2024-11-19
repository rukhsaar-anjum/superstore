with
    top_performers as (
        select 
            state_or_province, 
            region, 
            sum(sales) as total_sales
        from {{ ref("sales_fact") }} sales_fact
        left join
            {{ ref("customers_dim") }} customers_dim
            on sales_fact.customer_id = customers_dim.customer_id
        where extract('year', order_date) = 2019
        group by state_or_province, region
        order by total_sales desc
    )

select 
    state_or_province, 
    region, 
    total_sales
from top_performers
