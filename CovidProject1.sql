--Percentage of Deaths from the total cases in a particular location
--This shows the percentage of death if one contact covid in one's location 

select location, total_cases, total_deaths, (total_deaths/total_cases)*100 as PercentTotalDeaths 
from CovidDeaths2
order by 1,2

--Percentage of Total cases with respect to the population
--This shows what percentage of population have got covid

select location, date,total_cases,population, (total_cases/population)*100 as PercentageOfPopWithCovid 
from CovidDeaths2
where location = 'czechia'
order by 1,2


--Country with Highest Infectious Rate compared to Population

select location,population,max(total_cases) as MaxTotalCase, max(total_cases/population)*100 as TotalCasePercentage
from CovidDeaths2
group by location,population
order by TotalCasePercentage desc


-- Percentage Countries with Highest Death Count per Population

select location,population, max(cast(total_deaths as int)) as TotalDeathCount, MAX(total_deaths/population)*100  as TotalDeathCountPercentage
from coviddeaths2
group by location,population
order by TotalDeathCountPercentage desc


-- Countries with Highest Death Count per Population

select location,population, max(cast(total_deaths as int)) as TotalDeathCount
from coviddeaths2
where continent is not null
group by location,population
order by TotalDeathCount desc


--Global Results

select sum(new_cases)as TotalNewCases, sum(cast(new_deaths as int))as TotalDeaths, sum(cast(new_deaths as int))/SUM(new_cases)*100 as TotalDeathPercentage
from CovidDeaths2
where  continent is not null
order by 1,2

-- Total people in the world that have been vaccinated

select dea.continent, dea.location, dea.date,dea.population, dea.new_vaccinations, sum(cast(dea.new_vaccinations as int)) 

over(partition by dea.location order by dea.location, dea.date)as RollingPeopleVaccinated
 from CovidDeaths2 as dea
join CovidVaccinations2 as vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2,3




