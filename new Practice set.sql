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

Select prod_id,
    round (sum(sales),2) as total_sales
from market_fact_full 
group by prod_id