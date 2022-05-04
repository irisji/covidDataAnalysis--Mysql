select *
from coviddeaths
where continent =''
order by 1,2;

-- deaths rate of covid
select location, date, total_cases, total_deaths,round( total_deaths/total_cases *100,2) as percentage_of_deaths
from coviddeaths
where total_deaths is not null
order by 1,2;

-- deaths rate of covid at austrailia
-- the likelihood of dying if you contract covid in australia
select location, date, total_cases, total_deaths,round( total_deaths/total_cases *100,2) as percentage_of_deaths
from coviddeaths
where total_deaths is not null
and location  = 'Australia'
order by 1,2;

-- total cases vs populations in australia
select location, date, total_cases, population, round( total_cases/population *100,2) as percentage_of_infection
from coviddeaths
where total_cases is not null
and location  = 'Australia'
order by 1,2;


 

-- which country has the highest infection rate
select location,  round(total_cases/population*100,2) as infection_rate
from coviddeaths
where date ='2022-03-29'
order by infection_rate desc;


-- which country has the highest death ount
select location, total_deaths
from coviddeaths
where date ='2022-03-29'
and continent !=''
order by total_deaths desc;


-- which country has the highest death rate
select location, round(total_deaths/total_cases*100,2) as death_rate
from coviddeaths
where date ='2022-03-29'
order by death_rate desc;

-- which continent has the highest death count
select continent, sum(total_deaths) as total_deaths
from coviddeaths
where date ='2022-03-29'
and continent !=''
group by continent
order by total_deaths desc;

select location, sum(total_deaths) as total_deaths
from coviddeaths
where date ='2022-03-29'
and continent =''
group by location
order by total_deaths desc;

-- global number
select date, 
			sum(new_cases) as total_new_cases, 
			sum(new_deaths) as total_new_deaths, 
			round(sum(new_deaths)/sum(new_cases)*100, 2) as death_percentage
from coviddeaths
where continent !=''
group by date;

-- til  2022-03-29, what is the global death rate
select  sum(new_cases) as total_new_cases, 
			sum(new_deaths) as total_new_deaths, 
			round(sum(new_deaths)/sum(new_cases)*100, 2) as death_percentage
from coviddeaths
where continent !='';

-- Look at the total population VS vaccination
select *
from coviddeaths dea
join covidvaccinations vac
		on dea.location=vac.location
        and dea.date=vac.date
where dea.continent != '';

-- new vaccination  per day 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from coviddeaths dea
join covidvaccinations vac
		on dea.location=vac.location
        and dea.date=vac.date
where dea.continent != '';

-- rolling vaccination throughout the time
-- total vaccination throughout the time 
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
			sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as rolling_vaccination
from coviddeaths dea
join covidvaccinations vac
		on dea.location=vac.location
        and dea.date=vac.date
where dea.continent != '' ;

-- rolling vaccination rate over population throughout the time
-- total vaccination rate over population throughout the time 
with PopvsVac as 
	(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
				sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date) as rolling_vaccination
	from coviddeaths dea
	join covidvaccinations vac
			on dea.location=vac.location
			and dea.date=vac.date
	where dea.continent != '' )
select continent, location, date, population, new_vaccinations, rolling_vaccination, (rolling_vaccination/population)*100 as rolling_vac_pct
from PopvsVac
where location like '%state%'
;

with PopvsVac as 
	(select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
				sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)*100 as rolling_vaccination
	from coviddeaths dea
	join covidvaccinations vac
			on dea.location=vac.location
			and dea.date=vac.date
	where dea.continent != '' )
select continent, location,date, population,(rolling_vaccination/population)  as rolling_vac_rate
from PopvsVac
where date='2022-03-29'
order by 1, 2;

-- tem table
drop temporary table if exists PopvsVac;
create temporary table PopvsVac 
(
continent nvarchar(255),
location nvarchar(255),
date datetime, 
population bigint,
vaccination bigint,
rolling_vaccination bigint
) as 
(
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
				sum(vac.new_vaccinations) over (partition by dea.location order by dea.location, dea.date)*100 as rolling_vaccination
from coviddeaths dea
join covidvaccinations vac
		on dea.location=vac.location
		and dea.date=vac.date
);


-- select from temp table PopvsVac 
select continent, location,date, population,(rolling_vaccination/population)  as rolling_vac_rate
from PopvsVac
where date='2022-03-29'
order by 1, 2; 


-- deaths rate of covid at austrailia
-- the likelihood of dying if you contract covid in australia
select location, date, total_cases, total_deaths,round( total_deaths/total_cases *100,2) as percentage_of_deaths
from coviddeaths
where total_deaths is not null
and location  = 'Australia'
order by 1,2;


-- create view of percentage of deaths
-- the likelihood of dying if you contract covid in australia
create view pct_deaths_au as 
	select location, date, total_cases, total_deaths,round( total_deaths/total_cases *100,2) as percentage_of_deaths
	from coviddeaths
	where total_deaths is not null
	and location  = 'Australia';

select * from pct_deaths;

-- create procedure that fetch the percentage of deaths for each country at date '2022-3-29'
delimiter //
drop procedure if exists countryPctDeaths;
create procedure  countryPctDeaths (IN country nvarchar(255), OUT pct_deaths float)
       begin
         select round(total_deaths/total_cases*100,2)  into pct_deaths 
         from coviddeaths
         where location = country 
         and date='2022-03-29';
       end//
delimiter ;

-- call procedure
call countryPctDeaths('Australia',@pct_deaths);
select @pct_deaths;
