use PortfolioProject;
drop table coviddeaths;
truncate coviddeaths;

CREATE TABLE `coviddeaths` (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date` date,
  `population` bigint DEFAULT NULL,
  `total_cases` int DEFAULT NULL,
  `new_cases` int DEFAULT NULL,
  `new_cases_smoothed` float DEFAULT NULL,
  `total_deaths` int DEFAULT NULL,
  `new_deaths` int DEFAULT NULL,
  `new_deaths_smoothed` float DEFAULT NULL,
  `total_cases_per_million` double DEFAULT NULL,
  `new_cases_per_million` double DEFAULT NULL,
  `new_cases_smoothed_per_million` float DEFAULT NULL,
  `total_deaths_per_million` float DEFAULT NULL,
  `new_deaths_per_million` float DEFAULT NULL,
  `new_deaths_smoothed_per_million` float DEFAULT NULL,
  `reproduction_rate` float DEFAULT NULL,
  `icu_patients` int DEFAULT NULL,
  `icu_patients_per_million` int DEFAULT NULL,
  `hosp_patients` int DEFAULT NULL,
  `hosp_patients_per_million` float DEFAULT NULL,
  `weekly_icu_admissions` int DEFAULT NULL,
  `weekly_icu_admissions_per_million` float DEFAULT NULL,
  `weekly_hosp_admissions` int DEFAULT NULL,
  `weekly_hosp_admissions_per_million` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


LOAD DATA INFILE '/tmp/coviddeaths.csv'
	 INTO TABLE coviddeaths
	 FIELDS TERMINATED BY ','
 	 LINES TERMINATED BY '\r\n'
 IGNORE 1 ROWS
 (iso_code,continent,location,@date,@vpopulation, @vtotal_cases, @vnew_cases,
 @vnew_cases_smoothed, @vtotal_deaths, @vnew_deaths, @vnew_deaths_smoothed, 
 @vtotal_cases_per_million, @vnew_cases_per_million, @vnew_cases_smoothed_per_million, @vtotal_deaths_per_million, 
 @vnew_deaths_per_million, @vnew_deaths_smoothed_per_million, @vreproduction_rate,
 @vicu_patients, @vicu_patients_per_million, @vhosp_patients, @vhosp_patients_per_million, 
@vweekly_icu_admissions, @vweekly_icu_admissions_per_million, @vweekly_hosp_admissions, @vweekly_hosp_admissions_per_million)
SET
date=str_to_date(@date, '%d/%m/%Y'),
population=NULLIF(@vpopulation,''),
total_cases=NULLIF(@vtotal_cases,''),
new_cases=NULLIF(@vnew_cases,''),
new_cases_smoothed = NULLIF(@vnew_cases_smoothed,''),
total_deaths = NULLIF(@vtotal_deaths,''),
new_deaths = NULLIF(@vnew_deaths,''),
new_deaths_smoothed = NULLIF(@vnew_deaths_smoothed,''),
total_cases_per_million= NULLIF(@vtotal_cases_per_million,''),
new_cases_per_million= NULLIF(@vnew_cases_per_million,''),
new_cases_smoothed_per_million= NULLIF(@vnew_cases_smoothed_per_million,''),
total_deaths_per_million= NULLIF(@vtotal_deaths_per_million,''),
new_deaths_per_million=NULLIF(@vnew_deaths_per_million,''),
new_deaths_smoothed_per_million=NULLIF(@vnew_deaths_smoothed_per_million,''),
reproduction_rate=NULLIF(@reproduction_rate,''),
 icu_patients= NULLIF(@vicu_patients,''),
 icu_patients_per_million=NULLIF(@vicu_patients_per_million,''),
 hosp_patients=NULLIF(@vhosp_patients,''),
 hosp_patients_per_million=NULLIF(@vhosp_patients_per_million,''),
 weekly_icu_admissions=NULLIF(@vweekly_icu_admissions,''),
 weekly_icu_admissions_per_million=NULLIF(@vweekly_icu_admissions_per_million,''),
 weekly_hosp_admissions=NULLIF(@vweekly_hosp_admissions,''),
 weekly_hosp_admissions_per_million=NULLIF(@vweekly_hosp_admissions_per_million,'')
 ;
 
 set sql_mode ='ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
 
set sql_mode ='STRICT_TRANS_TABLES,ONLY_FULL_GROUP_BY,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
SHOW VARIABLES LIKE "sql_mode";

select * from coviddeaths
where weekly_hosp_admissions_per_million is not null
;

-- , @vtotal_cases_per_million, @vnew_cases_per_million,@vnew_cases_smoothed_per_million,
--  @vtotal_deaths_per_million








