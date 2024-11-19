**DBT Case Study**

I have split the given flattened data (order, people and returns) into fact (sales_fact) and dimensions tables (products_dim, customers_dim, dates_dim).

My reasoning for using star schema:
1. Easy to understand.
2. Easy for ad-hoc querying.
3. Easy to join between the tables and makes queries run faster even for large datasets.
4. Easy to maintain and extend.
5. Faster data access.


My reasoning for using multiple models to calculate the given metrics instead of one single model:
1. The given metrics involves different calculations and aggregations, so breaking them down into individual models will help to maintain them.
2. Helps in easier testing and debugging in case of issues.
3. Easily understandable by business users.
4. Can be used directly in reports/dashboards for specific analysis.

I have added tests and documentation to ensure data quality and understandable models by business.
You can find them here: https://github.com/rukhsaar-anjum/superstore/blob/main/models/global_superstore/schema.yml
