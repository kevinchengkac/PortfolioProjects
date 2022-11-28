/**--Selects all data from 2018-2021
Select * From InfluenzaStateLevels**/

--Selects data based on US' influenza activity level
--Orders by earliest season and date
Select state, activity_level, activity_level_label, date, week, season, year 
From InfluenzaStateLevels
Order By Year ASC, week ASC;

------------------State Examples--------------------------------------------------------
/**--Using Alabama as an example for how flu cases weakened throughout
--2020 as masks mandates start to occur due to the spread of Covid-19
Select state, activity_level, weekend
From InfluenzaStateLevels
Where state = 'Alabama'
Order By activity_level DESC;

--Selects data based on Florida's influenza activity level
--Orders by earliest season and date
Select state, activity_level, activity_level_label, weekend, week, season, date 
From InfluenzaStateLevels
Where state = 'Florida'
Order By date ASC;**/

---------------------------------------------------Deaths in the United States----------------------------------------------
--Lists all data of Covid, Pneumonia, and Influenza death cases in NA
--Orders list by ascending order by date
Select *
From us_c19_flu_pnu_deaths

--Lists dates, states, and disease deaths in all ages (leave pneu. deaths)
--Ordered by late 2019-present time
Select date, date_end, state, IsNull(c19_deaths, 0) As c19_deaths, --IsNull(pneu_deaths, 0)As pneumonia_deaths, 
	IsNull(flu_deaths, 0) As influenza_deaths
From PortfolioProject..us_c19_flu_pnu_deaths
Where age_group = 'All Ages'
Order By date ASC; 

---------------Combining the datasets together...?--------------------------------------------------------------------------
/**--Trying to put both datasets together
--Doesn't seem to work well; need to push start_week column down to match with 2019-2021 data
--Might not be possible to combine. Will leave code for now, but will probably have to use two 
--separate tables for the tableau project.
Select flu.state, flu.activity_level, flu.activity_level_label, flu.week, flu.season, flu.year, flu.date,
dea.date, IsNull(dea.c19_deaths, 0) As c19_deaths, IsNull(dea.flu_deaths, 0) as influenza_deaths
	From PortfolioProject..InfluenzaStateLevels As flu
    Join PortfolioProject..us_c19_flu_pnu_deaths As dea
		On flu.state = dea.state
		Order By flu.year ASC, flu.week ASC;**/

