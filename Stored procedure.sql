-- This SQL code creates a stored procedures named productsales that 
-- retrieves product id and sales data from the market_fact _full_table
-- when invoked the produre selects and display the prod_id and 
-- sales columns from the specified table 

DELIMITER $$
Create Procedure productsales()
BEGIN 
select prod_id,sales
from market_fact_full;

END $$

Delimiter ;

call productsales();


-- Below stored procedure named get_sales_customers accepts an integer input parameter sales_input. 
-- It retrieves distinct customer IDs along with their rounded sales amounts from a table named 
-- market_fact_full, filtering for sales amounts greater than the provided input.
-- The results are ordered by the rounded sales amounts.

Delimiter $$

Create procedure get_sales_customers (sales_input INT)
BEGIN
Select Distinct cust_id,
round(sum(sales), 2) as sales_Amount
from market_fact_full
group by Cust_id
having sales_amount > Sales_input
order by Sales_amount;
END$$
Delimiter ;

Call get_sales_customers (5000);

-- Define a user-defined function named square that takes an integer parameter X and returns the square of that integer.


Delimiter $$

Create function square1 (X INT)
Returns Int deterministic
begin 
Return X * X;
End
$$
Delimiter ;

Select Square (12);





-- Define a user-defined function named profitType that categorizes profits into different types based on predefined thresholds.
-- The function takes an integer parameter profit and returns a varchar message indicating the profit type.




