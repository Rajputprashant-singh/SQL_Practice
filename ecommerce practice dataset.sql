create database superstore_db;

use superstore_db;

Select count(order_ID)
from orders_dimen;

show tables;
Select * from Cust_dimen;
Select * from market_fact;
select * from orders_dimen;
select * from prod_dimen;
select * from shipping_dimen;


-- A. Find the total and the average sales (display total_sales and avg_sales) 

Select sum(sales), avg(sales)
from market_fact;

-- B. Display the number of customers in each region in decreasing order of 
-- no_of_customers. The result should contain columns Region, no_of_customers

/* E. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and
the number of tables purchased (display the customer name, no_of_tables
purchased)
*/

select cd.Cust_id, cd.Customer_Name, sum(mf.Order_quantity) as no_of_tables
from cust_dimen as cd join
market_fact as mf using(cust_id)join
prod_dimen as pd using (prod_id)
where cd.region = 'Atlantic' and pd.product_sub_category = 'Tables'
group by cd.cust_id,cd.customer_name
order by cd.Customer_Name;

-- Display the product category, product sub-category and the profit within each sub-category in three columns.

select pd.Product_Sub_Category,sum(profit) as net_profit
from market_fact as mf join prod_dimen as pd using (prod_id)
group by pd.product_sub_category
order by net_profit ;
