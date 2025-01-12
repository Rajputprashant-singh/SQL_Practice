---------------------------------------------------------------------------------------------------------------
-- 1. Print the product categories and subcategories along with the profits made for each order.


-- 2. Find the shipment date, mode and profit made for every single order.


-- 3. Print the shipment mode, profit made and product category for each product.


-- 4. Which customer ordered the most number of products?

Select Customer_Name,city, Sum(order_Quantity) as total_qty
from market_fact_full as mf left join
cust_dimen as cd using(cust_id)
group by cust_id
order by total_qty desc
limit 1;

-- alternate way


-- 5. Selling office supplies was more profitable in Delhi as compared to Patna. True or false?

Select cd.city, sum(mf.profit) as total_profit
from cust_dimen as cd
join market_fact_full as mf using(cust_id)
join prod_dimen as pd using (prod_id)
where pd.Product_Category = 'office supplies'
and cd.city in ('Delhi','Patna')
group by cd.city;


-- 6. Print the name of the customer with the maximum number of orders.

Select customer_name,count(distinct ord_id) as no_of_orders
from cust_dimen as cd
join market_fact_full as mf using(cust_id)
group by cust_id
order by no_of_orders desc
limit 3;


-- 7. Print the three most common products.
Select prod_id
from prod_dimen as pd join market_fact_full as mf 
group by prod_id;

Select prod_id, count(distinct ord_id) as no_of_orders
from Market_fact_full
group by prod_id
order by no_of_orders desc
limit 3;

-- -----------------------------------------------------------------------------------------------------------------
-- Outer Join
-- 1. Display the products sold by all the manufacturers using both inner and outer joins.

-- Displaying the names of all the manufacturers with the total number of products supplied by them.

-- Right Join

--------------------------------------------------------------------------------------------------------------
-- Views with Joins

-- 4. Create a view to display the customer names, segments, sales, product categories and
-- subcategories of all orders. 
-- Use it to print the city wise total sales
--  of those customers who ordered more than 20
-- pens and art supplies products.

Create view cust_view as (

Select cust_id,
	    customer_name,
	    product_category
        customer_segment,
        sum(sales) as total_sales
from cust_dimen join market_fact_full using(cust_id)
			    join prod_dimen using (prod_id)
group by cust_id,product_category


);

-- Use it to print the city wise total sales

select cd.city,
        round(sum(total_sales),2) as city_wise_sales
from cust_view as cs join
cust_dimen as cd
on cs.cust_id = cd.cust_id
group by cd.city
order by cd.city;