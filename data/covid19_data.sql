-- Create Database
CREATE DATABASE Covid19Analytics;
GO

USE Covid19Analytics;
GO

--------------------------------------------------
-- Countries Table
--------------------------------------------------
CREATE TABLE countries (
    country_id INT IDENTITY(1,1) PRIMARY KEY,
    country_name VARCHAR(100),
    continent VARCHAR(50)
);

--------------------------------------------------
-- Covid Cases Table
--------------------------------------------------
CREATE TABLE covid_cases (
    case_id INT IDENTITY(1,1) PRIMARY KEY,
    country_id INT,
    report_date DATE,
    confirmed INT,
    deaths INT,
    recovered INT,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

--------------------------------------------------
-- Vaccination Table
--------------------------------------------------
CREATE TABLE vaccinations (
    vaccination_id INT IDENTITY(1,1) PRIMARY KEY,
    country_id INT,
    report_date DATE,
    total_vaccinations INT,
    people_vaccinated INT,
    people_fully_vaccinated INT,
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

--------------------------------------------------
-- Insert Countries
--------------------------------------------------
INSERT INTO countries (country_name, continent)
VALUES
('USA', 'North America'),
('India', 'Asia'),
('Brazil', 'South America'),
('UK', 'Europe'),
('Australia', 'Oceania');

--------------------------------------------------
-- Insert COVID Cases
--------------------------------------------------
INSERT INTO covid_cases (country_id, report_date, confirmed, deaths, recovered)
VALUES
(1, GETDATE()-10, 5000, 50, 4000),
(1, GETDATE()-9, 6000, 60, 5000),
(2, GETDATE()-10, 10000, 100, 8000),
(2, GETDATE()-9, 12000, 120, 9500),
(3, GETDATE()-10, 7000, 80, 6000),
(3, GETDATE()-9, 8000, 90, 7000),
(4, GETDATE()-10, 3000, 30, 2500),
(4, GETDATE()-9, 3500, 35, 3000),
(5, GETDATE()-10, 1000, 10, 900),
(5, GETDATE()-9, 1200, 12, 1000);

--------------------------------------------------
-- Insert Vaccinations
--------------------------------------------------
INSERT INTO vaccinations (country_id, report_date, total_vaccinations, people_vaccinated, people_fully_vaccinated)
VALUES
(1, GETDATE()-10, 500000, 300000, 200000),
(1, GETDATE()-9, 520000, 320000, 200000),
(2, GETDATE()-10, 1000000, 600000, 400000),
(2, GETDATE()-9, 1050000, 650000, 400000),
(3, GETDATE()-10, 700000, 400000, 300000),
(3, GETDATE()-9, 750000, 450000, 300000),
(4, GETDATE()-10, 300000, 200000, 100000),
(4, GETDATE()-9, 320000, 220000, 100000),
(5, GETDATE()-10, 100000, 60000, 40000),
(5, GETDATE()-9, 120000, 70000, 50000);
