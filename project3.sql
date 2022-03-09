------------Depression Percentages by Education Level-----------------------------------------------------------

--Display the whole table
SELECT * FROM PortfolioProjects..depression_by_education_lvl$;

--Display table by average of active and employed----
SELECT entity, year, all_levels_total, below_upper_secondary_total, tertiary_total, upper_and_post_secondary_total
FROM PortfolioProjects..depression_by_education_lvl$;

---0----------------------Prevalence by Mental Substance--------------------------------------------------------

--Display whole table
SELECT * FROM PortfolioProjects..prevalence_by_mental_substance$

--Displays only mental disorders, filtered by entity first then year
SELECT entity, year, schizophrenia, bipolar_disorder, eating_disorders, anxiety_disorders, Drug_use_disorders, depression, alcohol_use_disorders
FROM PortfolioProjects..prevalence_by_mental_substance$
Where entity is not null
Order by entity, year;


------------------------Prevalence of Depression by Age--------------------------------------------------------

--Displays whole table
SELECT * FROM PortfolioProjects..prevalence_of_depression_by_age$

--Displays each age range by entity and year
SELECT entity, year, ten_to_fourteen_years_old, fifteen_to_nineteen_years_old, twenty_to_twentyfour_years_old, twentyfive_to_twentynine_years_old, thirty_to_thirtyfour_years_old, twentyfive_to_twentynine_years_old, seventyplus_years_old, all_ages
FROM PortfolioProjects..prevalence_of_depression_by_age$
Where entity is not null
Order by entity, year;

----------Prevalence of Depression in Males and Females--------------------------------------------------------

--Displays whole table
SELECT * FROM PortfolioProjects..prevalence_of_depression_males$

--Displays depression in male and females, ordered by entity then year
SELECT entity, year, prevalence_in_males, prevalence_in_females, population
FROM PortfolioProjects..prevalence_of_depression_males$
WHERE prevalence_in_males is not null
Order by entity, year;

---------------------------Suicide Rates vs. Prevalence--------------------------------------------------------

--Display whole table
SELECT * FROM PortfolioProjects..suicide_rates_vs_prevalence_of

/**Displays suicide rates and depression rates by entity, year, and population
Suicide Rates and Depressive Disorder Rates are by 100,000**/
SELECT entity, year, suicide_rate_deaths, depressive_disorder_rates, population
FROM PortfolioProjects..suicide_rates_vs_prevalence_of
WHERE 
	suicide_rate_deaths is not null 
	AND depressive_disorder_rates is not null
Order by entity, year;

---------------------------Joining the tables together--------------------------------------------------------

/**Take the statistics from spreadsheets 2-5 and
joining them onto the entity and year columns.
This will be the master spreadsheet for all the data.**/
SELECT
	mental.entity, mental.year, mental.schizophrenia, mental.bipolar_disorder, mental.eating_disorders, mental.anxiety_disorders, mental.Drug_use_disorders, mental.depression, mental.alcohol_use_disorders,
	depress_age.ten_to_fourteen_years_old,depress_age.fifteen_to_nineteen_years_old, depress_age.twenty_to_twentyfour_years_old, 
	depress_age.twentyfive_to_twentynine_years_old, depress_age.thirty_to_thirtyfour_years_old, depress_age.twentyfive_to_twentynine_years_old, 
	depress_age.seventyplus_years_old, depress_age.all_ages,
	depress_sex.prevalence_in_males, depress_sex.prevalence_in_females,
	suicide.suicide_rate_deaths, suicide.depressive_disorder_rates, suicide.population
FROM PortfolioProjects..prevalence_by_mental_substance$ as mental
	INNER JOIN PortfolioProjects..prevalence_of_depression_by_age$ as depress_age 
		ON depress_age.year = mental.year AND depress_age.entity = mental.entity
	INNER JOIN PortfolioProjects..prevalence_of_depression_males$ as depress_sex
		ON depress_sex.year = mental.year AND depress_sex.entity = mental.entity
	INNER JOIN PortfolioProjects..suicide_rates_vs_prevalence_of as suicide
		ON suicide.year = mental.year AND suicide.entity = mental.entity
WHERE depress_sex.prevalence_in_males is not null
	AND depress_sex.prevalence_in_females is not null
	AND suicide.suicide_rate_deaths is not null
	AND suicide.depressive_disorder_rates is not null
	AND suicide.population is not null
Order by mental.entity ASC, mental.year ASC;


