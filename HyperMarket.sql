create database Hypermarket;

use Hypermarket;



-- Q1. 

select Gender , avg(Points_earned) Avg_Points_Earned from customer
group by Gender;


-- Q2. 

select Customer_ID , sum(Points_redemed) Points_Redemed, 
(select avg(Points_redemed) from customer) Overall_Avg_Points_Redemed from customer
group by Customer_ID;

-- Q3. 

WITH customer_ltd AS (
    SELECT 
        User_ID,
        MAX(order_time) AS Last_Transaction_Date
    FROM Transactions
    GROUP BY User_ID
),
churn_flag AS (
    SELECT 
        User_ID,
        Last_Transaction_Date,
        CASE WHEN Last_Transaction_Date < '2013-01-01' THEN 1 
            ELSE 0 
        END AS Is_Churned
    FROM customer_ltd
)
SELECT 
    COUNT(*) AS Total_Customers,
    SUM(Is_Churned) AS Churned_Customers,
    ROUND(SUM(Is_Churned) * 100.0 / COUNT(*), 2) AS Percentage
FROM churn_flag;

-- Q4. 

select Customer_ID , sum(Points_earned) Points_Earned , 
rank() over( order by sum(Points_earned) desc ) Points_Rank
 from customer
group by Customer_ID;


-- Q5. 

select Gender , avg(Total_Orders) Avg_Total_Orders ,
rank() over( order by avg(Total_Orders) desc) Orders_Rank from customer
group by Gender;


-- Q6. 

with monthly_active as (
    select
        year(STR_TO_DATE(order_time, '%d-%m-%Y')) as Years,
        month(STR_TO_DATE(order_time, '%d-%m-%Y')) as Months,
        COUNT(DISTINCT User_ID) AS Active_Customers
    from Transactions
    group by year(STR_TO_DATE(order_time, '%d-%m-%Y')), month(STR_TO_DATE(order_time, '%d-%m-%Y'))
)
select
    Years, Months, Active_Customers,
    lag(Active_Customers) over (order by Years, Months)  Prev_Month_Active,
    Active_Customers - lag(Active_Customers) over (order by Years, Months)  MoM_Change
from monthly_active
order by Years, Months;

-- Q7 . 

select Merchant_Location , Customer_ID ,sum(Points_redemed) Points_Redemed,
rank() over( order by Merchant_Location desc) Location_Rank
 from customer c join transactions t on c.Customer_ID = t.User_ID join product p on t.Product_ID = p.Product_ID
 group by Merchant_Location , Customer_ID  ;


-- Q8. 

With monthly_active as (
    select 
        year(STR_TO_DATE(order_time, '%d-%m-%Y'))  Years,
        month(STR_TO_DATE(order_time, '%d-%m-%Y')) Months,
        COUNT(distinct User_ID)  Active_Customers
    from Transactions
    group by YEAR(STR_TO_DATE(order_time, '%d-%m-%Y')), month(STR_TO_DATE(order_time, '%d-%m-%Y'))
)
select 
    Years, Months, Active_Customers,
    sum(Active_Customers) over (order by Years, Months) Running_Total
from monthly_active
order by Years, Months asc;

-- Q9. 

select Customer_ID , week(STR_TO_DATE(order_time, '%d-%m-%Y')) Week_Number,
count(*) Transactions_Handled
 from customer c join transactions t on c.Customer_ID = t.User_ID
 group by Customer_ID , week(STR_TO_DATE(order_time, '%d-%m-%Y'))
 order by Transactions_Handled desc
 limit 5;


-- Q10. 


Select
    case 
        when STR_TO_DATE(LTD, '%Y%m%d') between '2013-01-01' and '2013-03-31' 
             and Customer_Total_value > 10000 then 'Loyal'
        when STR_TO_DATE(LTD, '%Y%m%d') between '2013-01-01' and '2013-03-31' then'Active'
        when STR_TO_DATE(LTD, '%Y%m%d') between '2012-09-01' and '2012-12-31' then 'Inactive'
        else 'Churned'
    end Segment,
    round(avg(Customer_Total_value), 2)  Avg_Customer_Value
from customer
group by Segment
order by Avg_Customer_Value desc;

