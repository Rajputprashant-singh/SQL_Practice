
/*
1. How many cities are there in the cities table?


2. Which country has the highest number of cities in the database?


3. Which language is its country’s official language and spoken by 80 to 90 percent of people?


4. In India, how many cities have been listed in “Maharashtra” district?


5. Which country has the maximum population (If population is taken as the population of the country table)?


6. Which language is spoken in the maximum number of countries?


7. Which language is the official language of the most number of countries?


8. How many cities in North America are there where English is the official language?


9. Which city has the maximum population among these cities?


10. How many row entries are there with any value in the country table being NULL?


11. How many countries are there whose name starts with I and ends with A ?

*/

-- 1. How many cities are there in the cities table?
SELECT count(Name)
from city;

-- Which country has the highest number of cities in the database?

Select countrycode,count(name)
from city
GROUP BY countrycode;

-- 3. Which language is its country’s official language and spoken by 80 to 90 percent of people?

Select *
from countrylanguage
where percentage between 80 AND 90 AND IsOfficial = 'T';

-- 4. In India, how many cities have been listed in “Maharashtra” district?

Select COUNT(*) AS City_count
From City
where Countrycode = 'IND' AND district = 'Maharashtra';