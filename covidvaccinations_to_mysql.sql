drop table covidvaccinations;
truncate table covidvaccinations;

CREATE TABLE `covidvaccinations` (
  `iso_code` text,
  `continent` text DEFAULT NULL,
  `location` text,
  `date` date,
  `total_tests` int DEFAULT NULL,
  `new_tests` int DEFAULT NULL,
  `total_tests_per_thousand` float DEFAULT NULL,
  `new_tests_per_thousand` float DEFAULT NULL,
  `new_tests_smoothed` float DEFAULT NULL,
  `new_tests_smoothed_per_thousand` float DEFAULT NULL,
  `positive_rate` float DEFAULT NULL,
  `tests_per_case` float DEFAULT NULL,
  `tests_units` text DEFAULT NULL,
  `total_vaccinations` bigint DEFAULT NULL,
  `people_vaccinated` bigint DEFAULT NULL,
  `people_fully_vaccinated` bigint DEFAULT NULL,
  `total_boosters` int DEFAULT NULL,
  `new_vaccinations` int DEFAULT NULL,
  `new_vaccinations_smoothed` float DEFAULT NULL,
  `total_vaccinations_per_hundred` float DEFAULT NULL,
  `people_vaccinated_per_hundred` float DEFAULT NULL,
  `people_fully_vaccinated_per_hundred` float DEFAULT NULL,
  `total_boosters_per_hundred` float DEFAULT NULL,
  `new_vaccinations_smoothed_per_million` float DEFAULT NULL,
  `new_people_vaccinated_smoothed` float DEFAULT NULL,
  `new_people_vaccinated_smoothed_per_hundred` float DEFAULT NULL,
  `stringency_index` double DEFAULT NULL,
  `population_density` double DEFAULT NULL,
  `median_age` double DEFAULT NULL,
  `aged_65_older` double DEFAULT NULL,
  `aged_70_older` double DEFAULT NULL,
  `gdp_per_capita` double DEFAULT NULL,
  `extreme_poverty` float DEFAULT NULL,
  `cardiovasc_death_rate` double DEFAULT NULL,
  `diabetes_prevalence` double DEFAULT NULL,
  `female_smokers` int DEFAULT NULL,
  `male_smokers` int DEFAULT NULL,
  `handwashing_facilities` double DEFAULT NULL,
  `hospital_beds_per_thousand` double DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL,
  `human_development_index` double DEFAULT NULL,
  `excess_mortality_cumulative_absolute` float DEFAULT NULL,
  `excess_mortality_cumulative` float DEFAULT NULL,
  `excess_mortality` float DEFAULT NULL,
  `excess_mortality_cumulative_per_million` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;



LOAD DATA INFILE '/tmp/covidvaccinations.csv'
	 INTO TABLE covidvaccinations
	 FIELDS TERMINATED BY ','
	 ENCLOSED BY '"'
 	 LINES TERMINATED BY '\r\n'
 IGNORE 1 ROWS
 (iso_code, @vcontinent, location, @date, @vtotal_tests, @vnew_tests, 
 @vtotal_tests_per_thousand, @vnew_tests_per_thousand, 
 @vnew_tests_smoothed, @vnew_tests_smoothed_per_thousand, 
 @vpositive_rate, @vtests_per_case, @vtests_units, @vtotal_vaccinations, 
 @vpeople_vaccinated, @vpeople_fully_vaccinated, @vtotal_boosters, 
 @vnew_vaccinations, @vnew_vaccinations_smoothed, 
 @vtotal_vaccinations_per_hundred, @vpeople_vaccinated_per_hundred, 
@vpeople_fully_vaccinated_per_hundred, @vtotal_boosters_per_hundred, 
 @vnew_vaccinations_smoothed_per_million, @vnew_people_vaccinated_smoothed, 
 @vnew_people_vaccinated_smoothed_per_hundred, @vstringency_index, 
 @vpopulation_density, @vmedian_age, @vaged_65_older, @vaged_70_older, 
 @vgdp_per_capita, @vextreme_poverty, @vcardiovasc_death_rate, @vdiabetes_prevalence,
 @vfemale_smokers, @vmale_smokers, @vhandwashing_facilities, 
 @vhospital_beds_per_thousand, @vlife_expectancy, @vhuman_development_index, 
 @vexcess_mortality_cumulative_absolute, @vexcess_mortality_cumulative, @vexcess_mortality, 
 @vexcess_mortality_cumulative_per_million)
 set
 
continent=NULLIF(@vcontinent,''),
date=str_to_date(@date, '%d/%m/%Y'),
total_tests=NULLIF(@vtotal_tests,''),
new_tests=NULLIF(@vnew_tests,''),
total_tests_per_thousand=NULLIF(@vtotal_tests_per_thousand,''),
new_tests_per_thousand=NULLIF(@vnew_tests_per_thousand,''),
new_tests_smoothed=NULLIF(@vnew_tests_smoothed,''),
new_tests_smoothed_per_thousand=NULLIF(@vnew_tests_smoothed_per_thousand,''),
positive_rate=NULLIF(@vpositive_rate,''),
tests_per_case=NULLIF(@vtests_per_case,''),
tests_units=NULLIF(@vtests_units,''),
total_vaccinations=NULLIF(@vtotal_vaccinations,''),
people_vaccinated=NULLIF(@vpeople_vaccinated,''),
people_fully_vaccinated=NULLIF(@vpeople_fully_vaccinated,''),
total_boosters=NULLIF(@vtotal_boosters,''),
new_vaccinations=NULLIF(@vnew_vaccinations,''),
new_vaccinations_smoothed=NULLIF(@vnew_vaccinations_smoothed,''),
total_vaccinations_per_hundred=NULLIF(@vtotal_vaccinations_per_hundred,''),
people_vaccinated_per_hundred=NULLIF(@vpeople_vaccinated_per_hundred,''),
people_fully_vaccinated_per_hundred=NULLIF(@vpeople_fully_vaccinated_per_hundred,''),
total_boosters_per_hundred=NULLIF(@vtotal_boosters_per_hundred,''),
new_vaccinations_smoothed_per_million=NULLIF(@vnew_vaccinations_smoothed_per_million,''),
new_people_vaccinated_smoothed=NULLIF(@vnew_people_vaccinated_smoothed,''),
new_people_vaccinated_smoothed_per_hundred=NULLIF(@vnew_people_vaccinated_smoothed_per_hundred,''),
stringency_index=NULLIF(@vstringency_index,''),
population_density=NULLIF(@vpopulation_density,''),
median_age=NULLIF(@vmedian_age,''),
aged_65_older=NULLIF(@vaged_65_older,''),
aged_70_older=NULLIF(@vaged_70_older,''),
gdp_per_capita=NULLIF(@vgdp_per_capita,''),
extreme_poverty=NULLIF(@vextreme_poverty,''),
cardiovasc_death_rate=NULLIF(@vcardiovasc_death_rate,''),
diabetes_prevalence=NULLIF(@vdiabetes_prevalence,''),
female_smokers=NULLIF(@vfemale_smokers,''),
male_smokers=NULLIF(@vmale_smokers,''),
handwashing_facilities=NULLIF(@vhandwashing_facilities,''),
hospital_beds_per_thousand=NULLIF(@vhospital_beds_per_thousand,''),
life_expectancy=NULLIF(@vlife_expectancy,''),
human_development_index=NULLIF(@vhuman_development_index,''),
excess_mortality_cumulative_absolute=NULLIF(@vexcess_mortality_cumulative_absolute,''),
excess_mortality_cumulative=NULLIF(@vexcess_mortality_cumulative,''),
excess_mortality=NULLIF(@vexcess_mortality,''),
excess_mortality_cumulative_per_million=NULLIF(@vexcess_mortality_cumulative_per_million,'');
 
 select * from covidvaccinations