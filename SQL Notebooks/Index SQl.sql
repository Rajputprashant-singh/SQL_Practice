

Create temporary table market_fact_temp
select * from market_fact_full;

Select * from market_fact_temp;


Show indexes from market_fact_full;


Show indexes from market_fact_temp;

Select * from market_fact_temp;


Set Profiling  = 1;

Select *
from market_fact_temp
where cust_id = "Cust_1818";

Show Profiles;