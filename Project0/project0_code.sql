--Shows the death percentage in the United States
Select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage, population 
From CovidDeaths$
Where location Like '%States%'
Order by 1, 2;

--Select location, date, total_cases, (total_cases/population)*100 As CasePercentage
From PortfolioProject..CovidDeaths$
Where location Like '%States%'
Order by 1,2;


/**Shows each country with the highest infection count to date, 
as well as amount of infected population as a percentage**/
Select Location, Population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as InfectedPopulationPercentage
From PortfolioProject..CovidDeaths$
Group by Location, Population
Order by 4 Desc;

--Shows the total death count by country
Select location, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by location
Order by TotalDeathCount desc;

--Shows the total death count by continent
Select continent, MAX(cast(total_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by continent
Order by TotalDeathCount desc;

--Shows the global Covid cases, deaths, and death percentages
Select date, SUM(new_cases) as Total_Cases, SUM(cast(new_deaths as int)) as Total_Deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths$
Where continent is not null
Group by date
Order by date;

--Combines the Death and Vaccination tables together on the location and date rows.
--Lists the new vaccinations of each day in each country with their population
--Creates CTE
With PopvsVac (continent, location, date, population, New_Vaccinations, RollingPeopleVaccinated) as 
(
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as bigint)) 
	Over (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated 
	From PortfolioProject..CovidDeaths$ as dea
	Join PortfolioProject..CovidVaxxed$ as vac
		On dea.location = vac.location
		and dea.date = vac.date
	Where dea.continent is not null
	--Order by 2,3
)
Select *, (RollingPeopleVaccinated/population)*100 
From PopvsVac

--Creates a temp. table
Drop Table if exists #PercentPopulationVaccianted
Create Table #PercentPopulationVaccianted
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)

Insert into #PercentPopulationVaccianted
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as bigint)) 
	Over (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated 
	From PortfolioProject..CovidDeaths$ as dea
	Join PortfolioProject..CovidVaxxed$ as vac
		On dea.location = vac.location
		and dea.date = vac.date
	Where dea.continent is not null
	Order by 2,3

Select *, (RollingPeopleVaccinated/population)*100 
From #PercentPopulationVaccianted

--Create a view for the percent of the population that are vaccinated
Create View PercentPopulationVaccianted as
	Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, SUM(cast(vac.new_vaccinations as bigint)) 
	Over (Partition by dea.location Order by dea.location, dea.date) as RollingPeopleVaccinated 
	From PortfolioProject..CovidDeaths$ as dea
	Join PortfolioProject..CovidVaxxed$ as vac
		On dea.location = vac.location
		and dea.date = vac.date
	Where dea.continent is not null
	--Order by 2,3

Select * From PercentPopulationVaccianted
