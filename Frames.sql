CREATE TABLE sales (
    sale_ID INT AUTO_INCREMENT PRIMARY KEY,
    sale_date DATE,
    amount DECIMAL(10, 2)
);

INSERT INTO sales (sale_date, amount) VALUES
('2024-03-01', 100),
('2024-03-02', 150),
('2024-03-03', 200),
('2024-03-04', 75),
('2024-03-05', 300),
('2024-03-06', 125),
('2024-03-07', 180),
('2024-03-08', 250);

    
select * from sales;

-- Below SQL queies selects sale_ID, sale_date, amount, and calculates the moving sum of amount using a window function frame.

-- Using rows
SELECT 
    sale_ID,
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_ID ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_sum
FROM 
    sales;
 
 
-- Using range
SELECT 
    sale_ID,
    sale_date,
    amount,
    SUM(amount) OVER (ORDER BY sale_date RANGE BETWEEN INTERVAL 1 DAY PRECEDING AND INTERVAL 1 DAY FOLLOWING) AS moving_sum
FROM 
    sales;




select * from orders_dimen;
select * from market_fact_full;


-- This query calculates the daily total shipping cost (daily_total) by joining the market_fact_full table with the shipping_dimen
-- table on the ship_id column. The result includes the ship_date and the corresponding daily_total shipping cost.
WITH daily_shipping_summary AS (
    SELECT 
        s.ship_date,
        SUM(m.shipping_cost) AS daily_total
    FROM 
        market_fact_full AS m
    INNER JOIN 
        shipping_dimen AS s ON m.ship_id = s.ship_id
    GROUP BY 
        s.ship_date
)

-- This query calculates the running total and 7-day moving average of daily sales using window functions with window
-- specifications w1 and w2, respectively.
SELECT 
    ship_date,
    daily_total,
    SUM(daily_total) OVER w1 AS running_total,
    AVG(daily_total) OVER w2 AS moving_avg
FROM 
    daily_shipping_summary
WINDOW 
    w1 AS (ORDER BY ship_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
    w2 AS (ORDER BY ship_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW);




-- This SQL query calculates daily sales summary from market_fact_full, grouped by order date. It computes running total and 
-- 7-day moving average of daily sales. Window functions SUM() and AVG() are used with specified window frames, ordered by order date.
WITH daily_sales_summary AS (
    SELECT 
        o.order_date,
        SUM(m.sales) AS daily_sales
    FROM 
        market_fact_full AS m
    INNER JOIN 
        orders_dimen AS o ON m.ord_id = o.ord_id
    GROUP BY 
        o.order_date
)
SELECT 
    order_date,
    daily_sales,
    SUM(daily_sales) OVER w1 AS running_total,
    AVG(daily_sales) OVER w2 AS moving_avg
FROM 
    daily_sales_summary
WINDOW 
    w1 AS (ORDER BY order_date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
    w2 AS (ORDER BY order_date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW);



-- This SQL query calculates the sum of sales for the current row and the two following rows for each customer.
SELECT 
    Market_fact_id,
    Ord_id,
    Prod_id,
    Ship_id,
    Cust_id,
    Sales,
    SUM(Sales) OVER(PARTITION BY Cust_id ORDER BY Market_fact_id ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS Next_2_Rows_Sales_Sum
FROM 
    market_fact_full;



-- This SQL query computes the 3-day moving average of sales for each product. It partitions the data by product ID, orders it by market fact ID,
--  and calculates the average sales for the current row and the two following rows.
SELECT 
    Market_fact_id,
    Ord_id,
    Prod_id,
    Ship_id,
    Cust_id,
    Sales,
    AVG(Sales) OVER(PARTITION BY Prod_id ORDER BY Market_fact_id ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING) AS ThreeDayMovingAvg
FROM 
    market_fact_full;


