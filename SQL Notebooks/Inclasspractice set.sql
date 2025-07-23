SELECT Round(avg(creditlimit))

FROM company.customers;
/*
--Which of the following are the top three countries (in order) that have the maximum number of customers?

Hint:

1. You need to use the 'customer' table. 
0
20. You will need to use a combination of 'group by' and 'order by' commands
*/

Select country,count(customerNumber) as cnumber
from customers
group by country
order by cnumber desc
limit 3;

/*

Using the 'products' table, calculate the sum of quantity in stock for the product vendor 'Red Start Diecast' and the product line 'Vintage Cars'? 

Count the total number of orders that have not been shipped yet, from the 'orders' table.
*/

Select productVendor,productLine, sum(quantityInStock)
from products
where productVendor ='Red Start Diecast' and productLine = 'Vintage Cars'
group by productVendor, productLine;

select count(status)
from orders
where status != 'Shipped';
