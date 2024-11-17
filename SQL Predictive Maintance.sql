create database if not exists CNC;
USE CNC;

-- Create Table 1: Machine Performance
CREATE TABLE Machine_Performance (
    Machine_ID VARCHAR(10),
    Date DATE,
    Spindle_Speed_RPM INT,
    Vibration_Level FLOAT,
    Temperature_C FLOAT,
    Operation_Hours INT,
    Machine_Status VARCHAR(20),
    Predicted_Failure VARCHAR(3)
);

-- Create Table 2: Failure Records
CREATE TABLE Failure_Records (
    Machine_ID VARCHAR(10),
    Failure_Date DATE,
    Failure_Type VARCHAR(50),
    Downtime_Hours FLOAT
);

-- Create Table 3: Maintenance Logs
CREATE TABLE Maintenance_Logs (
    Machine_ID VARCHAR(10),
    Maintenance_Date DATE,
    Technician_Name VARCHAR(50),
    Maintenance_Comments TEXT
);

-- Create Table 4: Machine Usage
CREATE TABLE Machine_Usage (
    Machine_ID VARCHAR(10),
    Date DATE,
    Parts_Produced INT,
    Production_Quality VARCHAR(20),
    Rejection_Rate FLOAT,
    Idle_Time FLOAT,
    Operator_Name VARCHAR(50)
);


-- Enable file imports (run this once in your MySQL session)
SET GLOBAL local_infile = 1;

-- Load Data into Tables
-- Below is the syntax to load data into each table:

LOAD DATA INFILE 'C:/Users/USER\Desktop/Predictive Maintance Dashboard Project/Machine_Performance.csv'
INTO TABLE Machine_Performance
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Machine_ID, @raw_date, Spindle_Speed_RPM, Vibration_Level, Temperature_C, Operation_Hours, Machine_Status, Predicted_Failure)
SET Date = STR_TO_DATE(@raw_date, '%m/%d/%Y');

-- Failure_Records Table
LOAD DATA INFILE 'C:/Users/USER\Desktop/Predictive Maintance Dashboard Project/Failure_Records.csv'
INTO TABLE Failure_Records
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Machine_ID, Failure_Date, Failure_Type, Downtime_Hours);

-- Maintenance_Logs Table
LOAD DATA INFILE 'C:/Users/USER\Desktop/Predictive Maintance Dashboard Project/Maintenance_Logs.csv'
INTO TABLE Maintenance_Logs
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Machine_ID, Maintenance_Date, Technician_Name, Maintenance_Comments);

-- Machine_Usage Table

LOAD DATA INFILE 'C:/Users/USER\Desktop/Predictive Maintance Dashboard Project/Machine_Usage.csv'
INTO TABLE Machine_Usage
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Machine_ID, Date, Parts_Produced, Production_Quality, Rejection_Rate, Idle_Time, Operator_Name);


-- Merge all tables based on Machine_ID and Date
CREATE VIEW Full_Machine_Data AS
SELECT 
    mp.Machine_ID,
    mp.Date,
    mp.Spindle_Speed_RPM,
    mp.Vibration_Level,
    mp.Temperature_C,
    mp.Operation_Hours,
    mp.Machine_Status,
    mp.Predicted_Failure,
    fr.Failure_Date,
    fr.Failure_Type,
    fr.Downtime_Hours,
    ml.Technician_Name,
    ml.Maintenance_Comments,
    mu.Parts_Produced,
    mu.Production_Quality,
    mu.Rejection_Rate,
    mu.Idle_Time,
    mu.Operator_Name
FROM Machine_Performance mp
LEFT JOIN Failure_Records fr ON mp.Machine_ID = fr.Machine_ID AND mp.Date = fr.Failure_Date
LEFT JOIN Maintenance_Logs ml ON mp.Machine_ID = ml.Machine_ID AND mp.Date = ml.Maintenance_Date
LEFT JOIN Machine_Usage mu ON mp.Machine_ID = mu.Machine_ID AND mp.Date = mu.Date;


-- Perform Data Analysis
-- 1.Summary of Machine Failures
SELECT Machine_ID, COUNT(Failure_Type) AS Failure_Count, SUM(Downtime_Hours) AS Total_Downtime
FROM Failure_Records
GROUP BY Machine_ID;

-- 2.Monthly Production Trends
SELECT DATE_FORMAT(Date, '%Y-%m') AS Month, SUM(Parts_Produced) AS Total_Production
FROM Machine_Usage
GROUP BY DATE_FORMAT(Date, '%Y-%m');

-- 3. Correlation Between Vibration Levels and Failures 
SELECT Machine_ID, AVG(Vibration_Level) AS Avg_Vibration, COUNT(Predicted_Failure) AS Failure_Predictions
FROM Machine_Performance
WHERE Predicted_Failure = 'Yes'
GROUP BY Machine_ID;

-- 4. Top 3 Machines with Highest Rejection Rates
SELECT Machine_ID, AVG(Rejection_Rate) AS Avg_Rejection_Rate
FROM Machine_Usage
GROUP BY Machine_ID
ORDER BY Avg_Rejection_Rate DESC
LIMIT 3;

-- 5.Idle Time Analysis
SELECT Machine_ID, SUM(Idle_Time) AS Total_Idle_Time
FROM Machine_Usage
GROUP BY Machine_ID
ORDER BY Total_Idle_Time DESC;

-- 6.Maintenance Efficiency
SELECT Technician_Name, COUNT(DISTINCT Machine_ID) AS Machines_Served, AVG(Downtime_Hours) AS Avg_Downtime
FROM Maintenance_Logs ml
JOIN Failure_Records fr ON ml.Machine_ID = fr.Machine_ID
GROUP BY Technician_Name;
