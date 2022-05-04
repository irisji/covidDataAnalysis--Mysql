select * from coviddeaths;
-- global number
 select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases) as death_rate
 from coviddeaths
 where continent !='';
 
 with cte as (
 select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths
 from coviddeaths
 where continent !=''
 )
 select total_cases, total_deaths, total_deaths/total_cases as death_rate
 from cte;
 
 select sum(total_cases) as total_cases, sum(total_deaths) as total_deaths, sum(total_deaths)/sum(total_cases) as death_rates
 from coviddeaths
 where date=(select max(date) from coviddeaths)
 and continent != '';
 
 -- global death rate overtime
select  date, sum(total_deaths)/sum(total_cases) as death_rate
 from coviddeaths
 where continent !=''
 group by date;
 
 -- each country's death rate
 select continent, location, ifnull(sum(new_deaths)/sum(new_cases),0) as death_rate
 from coviddeaths
 where continent !=''
 group by 1, 2;

-- country death rate overtime
select location, date, ifnull(total_deaths/total_cases, 0) as death_rate
from coviddeaths
where continent != '';

-- Australia death rate at 2022-03-29
select sum(new_cases) as total_cases, sum(new_deaths) as total_deaths, sum(new_deaths)/sum(new_cases) as death_rate
from coviddeaths
where continent !=''
and location ='Australia'; 
-- Australia death rate overtime
select date, ifnull(total_deaths/total_cases,0) as death_rate 
from coviddeaths
where continent !=''
and location='Australia';