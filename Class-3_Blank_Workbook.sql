-- SQL Statements DQL (data Query Lanuague )
-- SELECT and FROM
#select something from somewhere

-- Displaying only a single column

Select Customer_Name from cust_dimen;

-- Displaying only a multiple column

Select Customer_Name, city, state  from cust_dimen;

-- Displaying only all column

Select * from cust_dimen;

-- WHERE Clause
Select Customer_Name, customer_segment 
from cust_dimen 
where city = 'mumbai';

-- 

Select *
from prod_dimen
where Product_Category = 'Furniture';

--
Select *
from market_fact_full
where Profit > 1000;


--------------------------------------------------------------------------------------------------
--Operators
1. Arithmetic Operators
-- calulate net cost of each sales
select ord_id,cust_id,round (sales-profit,2) as net_cost
from market_fact_full;

-- Calculate the total revenue after discount for each sale

select * , sales (Sales*discount) as revenue 
from market_fact_full;

2. Comparison Operator
-- Find orders with more than 100 items ordered
Select * 
From market_fact_full
where order_quantity > 20;

Select ord_id,Round(sales,2),order_quantity as sales, Order_Quantity
from market_fact_full
where order_quantity > 20;

/*
3. Logical Operators
Suppose you want to find orders from the orders_dimen table that 
were placed on a specific date with a specific priority level.
*/
select *
from orders_dimen
where Order_Date = '2011-01-05' AND Order_Priority = 'HIGH';



/*
-- If you want to retrieve customers from the cust_dimen table who are either from the city 'Trivandrum' or 
from the city  'mumbai':
*/
select *
from cust_dimen
where City = 'Trivandrum' or City = 'Mumbai';

-- Suppose you want to display the customers who all belong to southern India so instead of writing multiple WHERE clauses you can make use of the IN operator.
select *
from cust_dimen
where state IN ('kerala', 'karnatka', 'tamil nadu');

select *
from cust_dimen
where state IN ('kerala', 'karnatka', 'tamil nadu');

select *
from cust_dimen
where state !='kerala';
----------------------------------------------------------------------------------------------------------

-- LIKE and Wildcards Examples

-- Suppose you want to find customer whose name starts with "K":

 select * 
 from cust_dimen
 where city like '%del%';
 


-- List the orders with '_5' in their order ids and shipping costs between 10 and 15.
Select *
from market_fact_full
where Ord_id like '%_5%'
AND Shipping_Cost >=10 
AND Shipping_Cost <=15 ;
      
-- OR       
Select * 
from market_fact_full
where Ord_id like '%_5%' 
AND Shipping_Cost between 10 AND 15;

-- To find any order IDs in the orders_dimen table that start with 'O' and have either 'r' or 'd' as the second character:



-- To get products whose sub-categories start with either "O", "T", or "F":

Select * 
FROM prod_dimen
where Product_Sub_Category like 'O%' 
OR Product_Sub_Category like 'T%'
OR Product_Sub_Category like 'F%';


-------------------------------------------------------------------------------------------------------

-- Aggregate functions
-- Count Function

Select count(manu_id)
from prod_dimen;

-- Count function is not counting for Null values 

-- without alias


 -- Null/Not-Null Values


-- Sum Function
Select sum(profit)
FROM market_fact_full;

-- Avg Function

Select avg(Profit)
from market_fact_full;

-- MIN Function Example

Select min(profit)
FROM market_fact_full;

-- MAX Function Example
Select max(profit)
FROM market_fact_full;



 -- Null Values

 -- throws an error as aggregate functions directly cannot be used in the where clause

----------------------------------------------------------------------------------------------------------

-- SQL Clauses
-- 1. Group By Clause
SELECT count(Cust_id) 
FROM cust_dimen
GROUP BY city;

SELECT city, count(Cust_id) AS no_of_customers
FROM cust_dimen
GROUP BY city;

SELECT Prod_id, AVG(SALES)
FROM market_fact_full
GROUP BY Prod_id;


-- Count City wise customers
 -- throw an error

Select city, state, count(cust_id) as no_of_customers
from cust_dimen
group by city; 

#above code is error - where select can be use in the table which is used by group by - for ex - city to city 

-- if we do same to same will be correct 

Select city, state, count(cust_id) as no_of_customers
from cust_dimen
group by city, state; 

-- Finding total profit from prod_id 

Select prod_id, sum(profit) as total_profit
from market_fact_full
group by prod_id;

-- every date what numbers of orders 
Select order_date, count(*) AS no_of_orders
From Orders_dimen
Group by order_date

-- 2. Order By Clause
Select order_date, count(*) AS no_of_orders
From Orders_dimen
Group by order_date
order by order_date;

Select order_date, count(*) AS no_of_orders
From Orders_dimen
Group by order_date
order by count(*);

Select order_date, count(*) AS no_of_orders
From Orders_dimen
Group by order_date
order by no_of_orders;

Select order_date, count(*) AS no_of_orders
From Orders_dimen
Group by order_date
order by no_of_orders DESC;

-- the next two queries look similar but will be displayed differently



-- Top 3 most ordered products

Select prod_id,  sum(order_quantity) as total_quantity_sold
from Market_fact_full
group by prod_id
order by total_quantity_sold DESC
limit 3;

-- ordering a column that does not exist

Select prod_id,  sum(order_quantity) as total_quantity_sold
from Market_fact_full
group by prod_id
order by profit desc; 
#order by profit desc;  - this line of code shows error beacuse after group by order by will not work 



-- Using ORDER BY with an aggregate function without it being part of a GROUP BY query or without using the function in the SELECT list:

Select cust_id,  sum(profit) AS Total_profit, round(Sum(sales),2) as Total_sales
from market_fact_full
where profit > 0
group by cust_id
order by total_profit desc
limit 3;


-- 3. Having Clause
-- If you want to know only about the products whose sale 
-- is greater than 2000

Select cust_id,  sum(profit) AS Total_profit, round(Sum(sales),2) as Total_sales
from market_fact_full
where profit > 0
group by cust_id
order by total_profit desc
limit 3;


-- If you want to know only about the products total sale 
-- is greater than 2000
Select Prod_id, round(sum(sales),2) as total sales 
from market_fact_full
group by prod_id
having total_sales > 2000
order by total_sales desc;



-------------------------------------------------------------------------------------------------------------

-- String Functions
-- 1. Concat()

select customer_name, concat (city,', ',state) as location
from cust_dimen;

select customer_name, concat_ws (', ', city, state) as location
from cust_dimen;

--2. UPPER()

Select Upper(City)
from Cust_dimen;


--3. LOWER()

Select Lower(City)
from Cust_dimen;

-- 4. LENGTH()

Select city ,length(city)
from Cust_dimen;

Select length(city)
from Cust_dimen;

-- Example: Suppose names of all the customers are in UPPER case and you want to convert them in title case
Select (city)
from Cust_dimen;

----------------------------------------------------------------------------------------------------------

-- Date-Time functions
-- Example 1: In which month were the most orders shipped? 
-- Here, we will count the number of shipments per month and 
-- then identify the month with the maximum shipments.

Select Year (Ship_date) as ord_year,
Month(ship_date) AS ord_month, 
count(order_id) AS number_of_orders
From Shipping_dimen
Group by year (Ship_date), month(Ship_date)
order by number_of_orders desc;


-- Example 2: Which month and year combination saw the most number of critical orders?

Select ord_id, Order_Priority,
year (Order_Date) as order_year, 
month(order_date) as order_month,
count(Ord_id) as no_of_order
from orders_dimen
where order_priority = 'critical'
group by ord_id 
order by no_of_order;

Select order_priority,
from
where orders priority
-- complete this in good way 

#year-month combo for 

select order_priority,
year (order_date) as ord_year
month(order_date) as order_month
count(ord_id) as no_of_orders

-- above is incomplete complete that 




-- NOW Function
 -- returns the current date and time

---------------------------------------------------------------------------------------------------------

--Regular Expressions
-- Example: Suppose you want to find names of all the customers who have a string ‘car’ in their name.
Select *
from cust_dimen
where customer_name regexp 'car';

-- Example: Find the names of all the customers beginning with a,b,c or d and ending with ‘er’.

Select *
from cust_dimen
where customer_name regexp '^[abcd].*er$';

-- REGEXP_REPLACE
-- Example: Suppose we want to remove all digits from the Customer_Name field in the cust_dimen table:


-- REGEXP_SUBSTR
-- Example:  Imagine you want to extract the first word from the Customer_Name field in the cust_dimen table. Assuming a word is any sequence of characters at the beginning of the string before a space:

--------------------------------------------------------------------------------------------------

-- Nested Queries
-- Example 1: Find the total sales for each order and compare it with the average sales for all orders.

select ord_id, round(sum(sales),2) as total_order_sales
from market_fact_full
group by ord_id
order by ord_id

select ord_id, 
round(sum(sales),2) as total_order_sales,
(Select round(avg(sales),2) from market_fact_full) as overall_avg_sales
from market_fact_full
group by ord_id
order by ord_id

--Example 2: Find details of customers who have made orders above $1000.

Select  cust_id,sum(sales)
from Market_fact_full
group by cust_id
having sum(sales>1000);


Select *
from cust_dimen
where Cust_id in  (cus_id141,241,341);

Select * 
from cust_dimen
where Cust_id in ( Select Cust_id
from Market_fact_full
group by cust_id
having sum(sales>1000)
);



-- **join**

Select m.Cust_id,city,state,round(sum(sales),2) 
from market_fact_full as M join cust_dimen as c
			on m.Cust_id = c.Cust_id
    group by m.Cust_id
    having sum(Sales) >1000;

-- Example 3: Get the average sales per customer, 
-- then select customers with average sales above a certain threshold above 500

Select Cust_id, avg (sales)
from market_fact_full 
group by Cust_id
having avg(sales) > 500;

-- subquery

Select * 
from cust_dimen
where Cust_id in (Select Cust_id
from market_fact_full 
group by Cust_id
having avg(sales) > 500);

Select m.cust_id, avg(sales), City, State
from market_fact_full as m join cust_dimen as c
on m.cust_id = c.Cust_id
group by m.cust_id
having avg(sales)> 500;

--------------------------------------------------------------------------------------------------------------
-- CTE( common table Expression)

-- 1. Find the 5 products which resulted in the least losses. 
-- Which product had the highest product base margin among these?

                    -- Query named as least_losses
Select Prod_id, sum(profit) as net_profit
from market_fact_full
group by prod_id
order by net_profit
limit 5;

-- Which product had the highest product base margin among these?\
-- common table expression

with T1 as (
Select Prod_id, sum(profit) as net_profit, 
                avg(Product_Base_Margin) as margin
from market_fact_full
group by prod_id
order by net_profit
limit 5)

Select * 
From T1
order by margin desc
limit 1;

 -- Query named as least_losses


-- 2. Find all low-priority orders made in the month of April. Out of them, how many were made in the first half of the month?

with tab1 as (
Select * 
from orders_dimen 
where month (Order_date) = '4' 
      AND (Order_priority) = 'low')
      
      select count(ord_id)
      from tab1
      where day(order_date) between 1 and 15;

-- Dervied Table 

-- TAble comes from subquery 

Select Count(ord_id)
from (Select * 
from orders_dimen 
where month (Order_date) = '4' 
      AND (Order_priority) = 'low') as tab1
 where day(order_date) between 1 and 15;

-- Views

create view tab_1 as  
(Select * 
from orders_dimen 
where month (Order_date) = '4' 
      AND (Order_priority) = 'low');
      
      
select count(ord_id)
from tab1
where day(order_date) between 1 and 10;

-- 1. Create a view to display the sales amounts, the number of orders, profits made and the shipping costs of all orders. Query it to return all orders which have a profit of greater than 1000.


-- 2. Which year generated the highest profit?