-- This query categorizes profits from market fact full table into differenty 


Select Market_fact_id,Profit,
case
when profit <-500 then "Huge Loss"
when profit between -500 AND 0 then "Bearable loss"
when profit between 0 AND 500 then "decent profit"
else "great profit"

END as Profit_type
From market_fact_full;



-- call 5 top highest selling as high- selling 
-- next 5 as medium selling a nd rest all as low selling 

with CTE1 As (
Select prod_id,
    round (sum(sales),2) as total_sales,
    rank() over (order by sum(sales) desc) as Sales_rank
from market_fact_full 
group by prod_id
order by total_sales desc
)
Select *,
case 
when Sales_rank <= 5 then "High Selling"
when sales_rank between 6 and 10 then "Medium Selling"
else 'Low-selling'
end as 'prod_sales_category'
from CTE1;