

select
    category as product_category,
    sum(sales) as total_sales,
    sum(case when sales_fact.is_returned then sales_fact.quantity end) as total_returned
from {{ ref('sales_fact') }} sales_fact
left join {{ ref('products_dim') }} products_dim
    on sales_fact.product_id = products_dim.product_id
where extract(year from order_date) = 2019
group by product_category