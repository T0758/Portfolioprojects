SELECT * FROM CovidData; 

--selecting sum of cases and deaths in each state

SELECT State, SUM(Total_cases), SUM(Deaths)
FROM CovidData 
GROUP BY State
ORDER BY sum(Total_cases); 

--selecting maximum deaths and maximum total cases in each state

SELECT State, Max (Deaths) as Max_Deaths, Max(Total_cases) as Max_Cases
FROM CovidData
GROUP BY State
ORDER BY Max_Deaths;

SELECT State, Max (Deaths) as Max_Deaths, Max(Total_cases) as Max_Cases
FROM CovidData
GROUP BY State
ORDER BY Max_Cases;

--minimum deaths and minimum total_cases in each state
 SELECT State, Min(Deaths) as Min_Deaths, Min(Total_cases) as Min_Cases
 FROM CovidData
 GROUP BY State
 ORDER BY Min_Deaths;

 SELECT State, Min(Deaths) as Min_Deaths, Min(Total_cases) as Min_Cases
 FROM CovidData
 GROUP BY State
 ORDER BY Min_Cases;

--percentage deaths in each state
SELECT State, SUM(Deaths) AS TotalDeathCount,
 SUM(Total_cases) AS TotalCasesCount,(SUM (Deaths)/SUM(Total_cases))*100 as DeathPercentage 
FROM CovidData
GROUP BY State
ORDER BY DeathPercentage DESC; 

SELECT  State, SUM(Deaths) AS TotalDeathCount,
 SUM(Total_cases) AS TotalCasesCount,(SUM (Deaths)/SUM(Total_cases))*100 as DeathPercentage 
FROM CovidData
GROUP BY  State
ORDER BY DeathPercentage asc; 

--percentage new deaths 
SELECT Date, SUM(New_cases), SUM(NewDeaths), (SUM(New_cases)/SUM(NewDeaths))
*100 AS PercentageNewDeaths  
FROM covidData
GROUP BY Date
ORDER BY PercentageNewDeaths desc; 

Select * from VaccinationData;

RENAME TABLE India_VaccinationData TO VaccinationData,
covid_19_data TO CovidData; 




--Creating a cte
With PopVsVacc as 
(
SELECT dea.State, SUM(vac.Total) OVER (PARTITION BY dea.State ORDER BY dea.State ) as TotalPopulation, SUM( vac.Total_vaccinated) OVER (PARTITION BY dea.State ORDER BY dea.State)
as TotalVaccinated
FROM CovidData dea 
JOIN VaccinationData vac 
ON dea.State = vac.State 
ORDER BY dea.State DESC
) 
SELECT *, (TotalVaccinated/TotalPopulation)*100 
FROM PopVsVacc 


--Creating view to stored data for later visualization 

CREATE VIEW PopVsVacc  AS     
SELECT dea.State, SUM(vac.Total) OVER (PARTITION BY dea.State ORDER BY dea.State ) as TotalPopulation, SUM( vac.Total_vaccinated) OVER (PARTITION BY dea.State ORDER BY dea.State)
as TotalVaccinated
FROM CovidData dea 
JOIN VaccinationData vac 
ON dea.State = vac.State; 

