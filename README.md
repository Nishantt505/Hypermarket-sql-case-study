# HyperMarket SQL Case Study

A SQL case study on a hypermarket's customer, transaction and product data, answering 10 business questions using MySQL.

## Business Questions Covered

1. Average points earned by gender
2. Points redeemed per customer vs overall average
3. Customer churn percentage (based on last transaction date)
4. Customer ranking by points earned
5. Average total orders by gender, with ranking
6. Month-over-month change in active customers
7. Points redeemed by customer across merchant locations
8. Running total of active customers by month
9. Top 5 customer-weeks by transactions handled
10. Customer segmentation: Loyal / Active / Inactive / Churned

## SQL Concepts Used

- CTEs (Common Table Expressions)
- Window Functions: RANK(), LAG(), running SUM() OVER()
- Joins and Subqueries
- CASE WHEN for segmentation logic
- Date functions: STR_TO_DATE, YEAR, MONTH, WEEK
- GROUP BY and Aggregations

## Tools

- MySQL

## Files

- `HyperMarket.sql`: all 10 queries

## Key Takeaway

Working with date columns stored as text taught me to always check data types and formats before writing date-based logic.

## Author

Nishant Singh Kushwah
B.Tech CSE (Data Science), ITM Gwalior | Data Science at AnalytixLabs, Bangalore
