CREATE TABLE employees (
    EmpCode INT PRIMARY KEY,
    EmpName VARCHAR(50),
    JoiningDate DATE
);

INSERT INTO employees (EmpCode, EmpName, JoiningDate) VALUES
(3, 'Sonu', '2018-03-10'),
(1, 'Rajendra', '2018-09-01'),
(2, 'Manoj', '2018-10-01'),
(4, 'Kashish', '2018-10-25'),
(6, 'Akshita', '2018-11-01'),
(5, 'Tim', '2018-12-01');

SELECT * from employees;

-- Below SQL query selects EmpCode, EmpName, JoiningDate, and calculates the End date using the LEAD function.
SELECT 
    EmpCode,
    EmpName,
    JoiningDate,
    LEAD(JoiningDate, 1) OVER (ORDER BY JoiningDate) AS EndDate
FROM 
    employees;

SELECT 
    EmpCode,
    EmpName,
    JoiningDate,
    LEAD(JoiningDate, 2) OVER (ORDER BY JoiningDate) AS EndDate
FROM 
    employees;

-- This query computes the difference in days between consecutive joining dates. This facilitates analysis of durations
-- between successive employee joinings.
SELECT 
    EmpCode,
    EmpName,
    JoiningDate,
    LEAD(JoiningDate, 1) OVER (ORDER BY JoiningDate) AS EndDate,
    DATEDIFF(LEAD(JoiningDate, 1) OVER (ORDER BY JoiningDate), JoiningDate) AS Difference
FROM 
    employees;

SELECT *,
    LEAD(JoiningDate, 1) OVER (ORDER BY JoiningDate) AS Relieving_Date,
    DATEDIFF(LEAD(JoiningDate, 1) OVER (ORDER BY JoiningDate), JoiningDate) AS days_of_service
FROM 
    employees;


-- Below SQL query selects EmpCode, EmpName, JoiningDate, and calculates the End date using the LAG function and computes the Difference.
SELECT 
    EmpCode,
    EmpName,
    JoiningDate,
    LAG(JoiningDate, 1) OVER (ORDER BY JoiningDate) AS EndDate,
    DATEDIFF(LAG(JoiningDate, 1) OVER (ORDER BY JoiningDate), JoiningDate) AS Difference
FROM 
    employees;
    
    SELECT *,
    LAG(JoiningDate, 1) OVER w AS EndDate,
    DATEDIFF(LAG(JoiningDate, 1) OVER w, JoiningDate) AS Difference
FROM 
    employees

Window w as (ORDER BY JoiningDate DESC);

select * from market_fact_full;


-- The SQL code first retrieves customer orders placed by "Rick Wilson" from the market_fact_full table, including order date and ID.
--  It then uses window function LEAD to find the subsequent order date for each order. Finally, it calculates the difference in days
--  between consecutive orders for Rick Wilson, providing insights into order frequency.
with cust_order as
(
select c.customer_name, 
		m.ord_id,
        o.order_date
from
market_fact_full as m
left join
orders_dimen as o
on m.ord_id = o.ord_id
left join 
cust_dimen as c
on m.cust_id=c.cust_id
where customer_name= 'Rick Wilson'
group by 
		c.customer_name,
        m.ord_id,
        o.order_date
),
next_date_summary as 
(select *,
		lead(order_date, 1, '2015-01-01') over (order by order_date,ord_id) as next_order_date
from cust_order
order by customer_name,
		 order_date,
         ord_id
)
select * , DATEDIFF(next_order_date, order_date) as days_diff
from next_date_summary;

-- Find how many days where no orderes are placed 
With CTE1 as (
Select order_date,count(ord_id) as no_of_orders
from orders_dimen
group by Order_date 
order by order_date
),
CTE2 as (
  Select *, 
  lead (order_date,1) Over win as next_ord_date,
  datediff(lead(order_date,1) Over win, order_date) as gap_days
  from CTE1
  Window win as (order by order_date)
  )
  
  Select count(order_date) as zero_order_days
  from CTE2 where gap_days >1 ;