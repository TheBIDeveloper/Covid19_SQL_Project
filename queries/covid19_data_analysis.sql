USE Covid19Analytics;
GO

--------------------------------------------------
-- 1. Total confirmed cases globally
--------------------------------------------------
SELECT SUM(confirmed) AS total_confirmed
FROM covid_cases;

--------------------------------------------------
-- 2. Total deaths globally
--------------------------------------------------
SELECT SUM(deaths) AS total_deaths
FROM covid_cases;

--------------------------------------------------
-- 3. Total recovered globally
--------------------------------------------------
SELECT SUM(recovered) AS total_recovered
FROM covid_cases;

--------------------------------------------------
-- 4. Total cases per country
--------------------------------------------------
SELECT c.country_name,
       SUM(cc.confirmed) AS total_confirmed
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_confirmed DESC;

--------------------------------------------------
-- 5. Total deaths per country
--------------------------------------------------
SELECT c.country_name,
       SUM(cc.deaths) AS total_deaths
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_deaths DESC;

--------------------------------------------------
-- 6. Total recovered per country
--------------------------------------------------
SELECT c.country_name,
       SUM(cc.recovered) AS total_recovered
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_recovered DESC;

--------------------------------------------------
-- 7. Daily new cases per country
--------------------------------------------------
SELECT c.country_name,
       cc.report_date,
       cc.confirmed AS new_cases
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
ORDER BY c.country_name, cc.report_date;

--------------------------------------------------
-- 8. Daily deaths trend per country
--------------------------------------------------
SELECT c.country_name,
       cc.report_date,
       cc.deaths AS daily_deaths
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
ORDER BY c.country_name, cc.report_date;

--------------------------------------------------
-- 9. Daily recovered trend per country
--------------------------------------------------
SELECT c.country_name,
       cc.report_date,
       cc.recovered AS daily_recovered
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
ORDER BY c.country_name, cc.report_date;

--------------------------------------------------
-- 10. Top 5 countries by confirmed cases
--------------------------------------------------
SELECT TOP 5 c.country_name,
       SUM(cc.confirmed) AS total_confirmed
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_confirmed DESC;

--------------------------------------------------
-- 11. Top 5 countries by deaths
--------------------------------------------------
SELECT TOP 5 c.country_name,
       SUM(cc.deaths) AS total_deaths
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_deaths DESC;

--------------------------------------------------
-- 12. Confirmed cases per continent
--------------------------------------------------
SELECT c.continent,
       SUM(cc.confirmed) AS total_confirmed
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.continent
ORDER BY total_confirmed DESC;

--------------------------------------------------
-- 13. Deaths per continent
--------------------------------------------------
SELECT c.continent,
       SUM(cc.deaths) AS total_deaths
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.continent
ORDER BY total_deaths DESC;

--------------------------------------------------
-- 14. Recoveries per continent
--------------------------------------------------
SELECT c.continent,
       SUM(cc.recovered) AS total_recovered
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.continent
ORDER BY total_recovered DESC;

--------------------------------------------------
-- 15. Total vaccinations per country
--------------------------------------------------
SELECT c.country_name,
       SUM(v.total_vaccinations) AS total_vaccinations,
       SUM(v.people_vaccinated) AS people_vaccinated,
       SUM(v.people_fully_vaccinated) AS people_fully_vaccinated
FROM vaccinations v
JOIN countries c ON v.country_id = c.country_id
GROUP BY c.country_name
ORDER BY total_vaccinations DESC;

--------------------------------------------------
-- 16. Vaccination trend per country
--------------------------------------------------
SELECT c.country_name,
       v.report_date,
       v.total_vaccinations
FROM vaccinations v
JOIN countries c ON v.country_id = c.country_id
ORDER BY c.country_name, v.report_date;

--------------------------------------------------
-- 17. Recovery rate per country
--------------------------------------------------
SELECT c.country_name,
       SUM(cc.recovered)*100.0/SUM(cc.confirmed) AS recovery_rate
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY recovery_rate DESC;

--------------------------------------------------
-- 18. Death rate per country
--------------------------------------------------
SELECT c.country_name,
       SUM(cc.deaths)*100.0/SUM(cc.confirmed) AS death_rate
FROM covid_cases cc
JOIN countries c ON cc.country_id = c.country_id
GROUP BY c.country_name
ORDER BY death_rate DESC;

--------------------------------------------------
-- 19. Highest daily new cases per country
--------------------------------------------------
WITH daily_cases AS (
    SELECT country_id, report_date, confirmed
    FROM covid_cases
)
SELECT c.country_name, dc.report_date, dc.confirmed AS new_cases
FROM daily_cases dc
JOIN countries c ON dc.country_id = c.country_id
WHERE dc.confirmed = (
    SELECT MAX(confirmed) FROM covid_cases WHERE country_id = dc.country_id
)
ORDER BY c.country_name;

--------------------------------------------------
-- 20. Highest daily deaths per country
--------------------------------------------------
WITH daily_deaths AS (
    SELECT country_id, report_date, deaths
    FROM covid_cases
)
SELECT c.country_name, dd.report_date, dd.deaths AS daily_deaths
FROM daily_deaths dd
JOIN countries c ON dd.country_id = c.country_id
WHERE dd.deaths = (
    SELECT MAX(deaths) FROM covid_cases WHERE country_id = dd.country_id
)
ORDER BY c.country_name;
