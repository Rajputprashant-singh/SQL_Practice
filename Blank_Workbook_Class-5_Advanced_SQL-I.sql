USE market_star_schema;

/*-------------------------------------------------------------------------------------------
Problem statement: Growth team wants to understand sustainable(profitable) product categories
Sustainability can be achieved when we make better profits or at least positive profits.
	We can look at the profits per product category.
	We can look at profits per product subcategory. 
	We can check Average profit per order
	Also, consider Average Profit % per order
--------------------------------------------------------------------------------------------*/

-- Summary at Prodcut Category and Sub category


-- Exploring order table


-- Calculating distinct order_id and order_number


-- To get details of order numbers with different order_ids


-- Calculating order level avg profit and overall summary

-- Calculating avg profit percentage
 
/*---------------------------------------------------------------------------------
Problem statement: Get the details of Top 10 profitable customers in form 
of a table shown below:
cust_id
rank
customer_name
profit
customer_city
customer_state
sales
---------------------------------------------------------------------------------*/

-- Exploring cust_dimen table

-- Ranking


-- To slect Top 10 customers

/*----------------------------------------------------------------------------
Share the following details of the customers who have placed only one order so far:
Cust_id
Customer_Name
City
State
Customer_Segment
Flag to indicate if there is another customer with the exact same name and 
city but a different cust_id (to understand if the same customer signed up again)
---------------------------------------------------------------------------- */

-- Exploring customer dimension tabel

-- List all customers who have not placed any order

-- Checking if really no such customers exist
-- 1832

-- 1832

-- Exploring order per user


-- Unique customer name and city check


-- Final Output



