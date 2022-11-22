/*
Covid 19 Data Exploration 
*/
select * from Covid19..CovidDeaths;

select * from Covid19..CovidVaccinations;
---------------------------------------------------------------------------------------------------------------------
-- Select data that we are going to use and order by location and date.

Select location, date, total_cases, new_cases, total_deaths, population
from Covid19..CovidDeaths
Order by 1, 2;
----------------------------------------------------------------------------------------------------------------------
-- Total Cases vs Total Death for every day

select location,date, total_cases, new_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathvsCases
from Covid19..CovidDeaths
order by 1, 2;
----------------------------------------------------------------------------------------------------------------------

-- Total Cases vs Total Death for every day filter by location (Example: United State)

select location,date, total_cases, new_cases, total_deaths, population, (total_deaths/total_cases)*100 as DeathvsCases
from Covid19..CovidDeaths
where location like '%state%'
order by 1, 2;
----------------------------------------------------------------------------------------------------------------------

-- Looking Total Cases vs Population

select location, date , total_cases, new_cases, total_deaths, population, (total_cases/population)*100 as CasesvsPopulation
from Covid19..CovidDeaths
order by 1, 2;
----------------------------------------------------------------------------------------------------------------------

-- Looking Total Cases vs Population filter by location (Example: Syria)

select location, date , total_cases, new_cases, total_deaths, population, (total_cases/population)*100 as CasesvsPopulation
from Covid19..CovidDeaths
where location = 'Syria'
order by 1, 2;
----------------------------------------------------------------------------------------------------------------------

-- Looking for highest infection rate compared to population order by the highest infection rate

select location, Max(total_cases) as highest_total_cases ,population, Max((total_cases/population)*100) as highest_infection_rate
from Covid19..CovidDeaths
group by location, population
order by 4 desc;
----------------------------------------------------------------------------------------------------------------------

--Looking for the countries with highest death count per population

select location, Max(cast(total_deaths as int)) as highest_total_death, population, Max((cast(total_deaths as int)/population)*100)as highest_death_rate
from Covid19..CovidDeaths
group by location, population
order by 4 desc;
----------------------------------------------------------------------------------------------------------------------

-- Lest's break down things by Continent

select distinct(continent) from Covid19..CovidDeaths;

select   continent, sum(cast(total_cases as bigint)) Sum_Total_Cases, sum(cast(total_deaths as bigint)) Sum_Total_Deaths
from Covid19..CovidDeaths
where continent IS NOT Null And total_cases IS NOT NULL And total_deaths is NOT NUll
group by continent;

----------------------------------------------------------------------------------------------------------------------

-- Global Death by Date

select date, sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) *100 as Death_percentage
from Covid19..CovidDeaths
where new_cases != 0 And new_cases IS Not Null
group by date
order by 1;

----------------------------------------------------------------------------------------------------------------------

-- Global Death

select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases) *100 as Death_percentage
from Covid19..CovidDeaths
where new_cases != 0 And new_cases IS Not Null
order by 1;

----------------------------------------------------------------------------------------------------------------------

--Total Population vs Vaccinations Using JOIN (CovidDeaths Table and CovidVaccinations Table)

select de.continent, de.location, de.date, de.location, va.new_vaccinations
from Covid19..CovidDeaths de join Covid19..CovidVaccinations va
on de.location = va.location
and de.date = va.date
where de.continent IS NOT NULL
order by 1,2,3;

----------------------------------------------------------------------------------------------------------------------