CREATE DATABASE UK_ROAD_ACCIDENT;
USE UK_ROAD_ACCIDENT;

# CHECKING DATA TYPE AND COLUMNS
SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'UK_ROAD_ACCIDENT' 
AND table_name = 'ACCIDENTS'; 

# CORRECTING THE COLUMN NAMES
ALTER TABLE ACCIDENTS
CHANGE `Engine_Capacity` Highway int,
CHANGE `Engine_Capacity` Highway text;

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'UK_ROAD_ACCIDENT' 
AND table_name = 'VEHICLES'; 

# CORRECTING THE COLUMN NAMES
ALTER TABLE VEHICLES
CHANGE `Was_Vehicle_Left_Hand_Drive?` Was_Vehicle_Left_Hand_Drive int,
CHANGE `Engine_Capacity_(CC)` Engine_Capacity int;


# Q1 Retrieve  columns for accidents that occurred on a specific date.
SELECT Date, Number_of_Vehicles, Number_of_Casualties,Light_Conditions FROM ACCIDENTS
GROUP BY DATE
ORDER BY DATE;

# Q2 List the accident severity, number of casualties, and weather conditions for accidents. 
SELECT Weather_Conditions ,Accident_Severity,COUNT(Number_of_Casualties) AS NUMBER_OF_CASUALITIES
FROM accidents
GROUP BY Weather_Conditions
ORDER BY Weather_Conditions;

# Q Calculate the percentage of accidents that occurred in urban areas versus rural areas.
SELECT Urban_or_Rural_Area,
    COUNT(*) AS TotalAccidents,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM accidents)),2) AS Percentage
FROM accidents
GROUP BY Urban_or_Rural_Area;

# Q3 Find the accidents with the highest number of vehicles involved.?
SELECT Accident_Index, (Number_of_Vehicles) 
FROM ACCIDENTS 
GROUP BY Accident_Index
ORDER BY NUMBER_OF_VEHICLES DESC;

# Q4 Retrieve the accident details and vehicle types involved in each accident.
SELECT V.Accident_Index AS ACCIDENT_INDEX, 
       VT.label AS VEHICLES ,
       A.Number_of_Casualties AS NUMBER_OF_CASUALTIES
FROM ACCIDENTS A
LEFT JOIN VEHICLES V ON A.Accident_Index= V.Accident_Index
LEFT JOIN vehicle_types VT ON V.Vehicle_Type = VT.code
GROUP BY V.Accident_Index,VT.label 
ORDER BY  NUMBER_OF_CASUALTIES  DESC;

# Q5 Find accidents where vehicles left the carriageway and the associated vehicle types
SELECT V.Accident_Index AS ACCIDENT_INDEX, VT.label AS VEHICLE_TYPES,V.Vehicle_Leaving_Carriageway AS VEHICLE_LEFT_Carriageway
FROM VEHICLE_TYPES VT
LEFT JOIN VEHICLES V 
ON VT.code = V.Vehicle_Type
GROUP BY ACCIDENT_INDEX,VEHICLE_TYPES;

# Q6  Calculate the average number of casualties per accident.
SELECT ROUND(AVG(Number_of_Casualties),2) AS AVERAGE_CASUALTIES
FROM ACCIDENTS
GROUP BY ACCIDENT_INDEX
ORDER BY AVERAGE_CASUALTIES DESC;

#Q7 Count the number of accidents for each day of the week.
SELECT Day_of_Week, COUNT(Accident_Index) AS NUMBER_OF_ACCIDENT
FROM ACCIDENTS
GROUP BY Day_of_Week
ORDER BY  Day_of_Week ASC ;

# Q8 Find the most common vehicle types involved in accidents for drivers of different genders.
SELECT Sex_of_Driver, Vehicle_Type, COUNT(*) AS Accident_Count
FROM Vehicles
GROUP BY Sex_of_Driver
ORDER BY  Accident_Count DESC;

# Q9 Find accidents where the driver's home area type matches the vehicle's IMD decile.
SELECT A.*, V.Driver_Home_Area_Type, V.Vehicle_IMD_Decile
FROM ACCIDENTS  A
INNER JOIN VEHICLES  V 
ON A.Accident_Index = V.Accident_Index
WHERE V.Driver_Home_Area_Type = V.Vehicle_IMD_Decile; 

# Q10 Identify accidents with vehicles that skidded and overturned.
SELECT V.Accident_Index,VT.label AS VEHICLE_TYPE, COUNT(V.Skidding_and_Overturning) AS Skidding_and_Overturning
FROM VEHICLE_TYPES VT
INNER JOIN VEHICLES V ON VT.code= V.Vehicle_Type
WHERE V.Skidding_and_Overturning = ! 0
GROUP BY V.Accident_Index
ORDER BY Skidding_and_Overturning DESC ;


# Q11 Find the most common weather condition during accidents.
SELECT Weather_Conditions, COUNT(*) AS COMMON_WEATHER_CONDITION FROM ACCIDENTS
GROUP BY Weather_Conditions
ORDER BY COMMON_WEATHER_CONDITION DESC ;

# Q12  Retrieve accidents where the speed limit was greater than 50km/hr.
SELECT Accident_Index,Speed_limit
FROM ACCIDENTS
WHERE Speed_limit >=50
GROUP BY 1,2
ORDER BY Speed_limit DESC;

# Q13 Identify the percentage of vehicles that skidded and overturend.
SELECT VT.label AS VEHICLE_TYPE, 
       SUM(CASE WHEN V.Skidding_and_Overturning = 'Yes' THEN 1 ELSE 0 END) AS Skidding_and_Overturning_Count,
       COUNT(*) AS Total_Accidents,
       ROUND((SUM(CASE WHEN V.Skidding_and_Overturning = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*)),2) AS Percentage
FROM VEHICLE_TYPES VT
LEFT JOIN VEHICLES V ON VT.code = V.Vehicle_Type
GROUP BY VEHICLE_TYPE
ORDER BY Percentage DESC;


#Q14  List accidents that occurred in urban areas and sort them by accident severity.
SELECT Urban_or_Rural_Area AS URBAN_AREA, Accident_Severity
FROM ACCIDENTS
WHERE Urban_or_Rural_Area = 1
GROUP BY Accident_Severity;

# Q15 Find accidents with a specific road type and sort them by the number of vehicles involved.
SELECT Road_Type, COUNT(Number_of_Vehicles) AS Number_of_Vehicles
FROM ACCIDENTS 
GROUP BY Road_Type
ORDER BY Number_of_Vehicles DESC;

# Q16 Calculate the average age of vehicles involved in accidents based on the age band of drivers.
SELECT Age_Band_of_Driver, ROUND(AVG(Age_of_Vehicle),2) AS AVG_AGE_OF_VEHICLES
FROM VEHICLES
GROUP BY Age_Band_of_Driver
ORDER BY Age_Band_of_Driver;

# Q17 Calculate the correlation between the age of drivers and the engine capacity of vehicles in accidents.

/*  MySQL does not have a built-in CORRELATION function SO I have to calculate it manually. 
 We can use SQL to calculate the covariance and standard deviations and then apply the correlation formula manually*/
SELECT
    SUM((Age_of_Driver - avg_age) * (Engine_Capacity - avg_capacity)) / ((COUNT(*) - 1) * STDDEV(Age_of_Driver) * STDDEV(Engine_Capacity)) AS Correlation
FROM
    VEHICLES
CROSS JOIN (
    SELECT AVG(Age_of_Driver) AS avg_age, AVG(Engine_Capacity) AS avg_capacity
    FROM VEHICLES
) AS subquery;


# Q18 List accidents and the most common driver journey purposes in rural areas.
SELECT A.Accident_Index, V.Journey_Purpose_of_Driver, COUNT(*) AS Purpose_Count
FROM ACCIDENTS A
LEFT JOIN VEHICLES V ON A.Accident_Index = V.Accident_Index
WHERE A.Urban_or_Rural_Area = 2
GROUP BY A.Accident_Index, V.Journey_Purpose_of_Driver
ORDER BY A.Accident_Index, Purpose_Count DESC;

# Q19 Calculate the average age of vehicles involved in accidents for each gender of the driver.
SELECT Sex_of_Driver, ROUND(AVG(Age_of_Vehicle),2) AS AVG_AGE_VEHICLES
FROM VEHICLES
GROUP BY Sex_of_Driver;

# Q20 Determine the percentage of accidents where the vehicle was left-hand drive, broken down by gender of the driver
SELECT Sex_of_Driver, 
       SUM(CASE WHEN Was_Vehicle_Left_Hand_Drive = 1 THEN 1 ELSE 0 END) AS Left_Hand_Drive_Count,
       COUNT(*) AS Total_Accidents,
       (SUM(CASE WHEN Was_Vehicle_Left_Hand_Drive = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS Percentage_Left_Hand_Drive
FROM Vehicles
GROUP BY Sex_of_Driver;

# Q21 Find the five districts with the highest number of accidents and the five districts with the lowest number of accidents.
SELECT District, COUNT(*) AS TOP_5_DISTRICT
FROM ACCIDENTS
GROUP BY District
ORDER BY TOP_5_DISTRICT DESC
LIMIT 5;

SELECT District, COUNT(*) AS BOTTOM_5_DISTRICT
FROM ACCIDENTS
GROUP BY District
ORDER BY BOTTOM_5_DISTRICT ASC
LIMIT 5;

# Q22 Calculate the average age of vehicles involved in accidents for each propulsion code.
SELECT Propulsion_Code, ROUND(AVG(Age_of_Vehicle),2) AS AVG_AGE_OF_VEHICLES
FROM VEHICLES
GROUP BY Propulsion_Code
ORDER BY AVG_AGE_OF_VEHICLES DESC;

# Q23 Find the most common first point of impact in accidents and the percentage of accidents it represents.
SELECT 1st_Point_of_Impact,
    COUNT(*) AS MOST_COMMON_IMPACT,
    ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM VEHICLES)),2) AS PERCENTAGE_OF_ACCIDENTS
FROM VEHICLES
GROUP BY 1st_Point_of_Impact
ORDER BY MOST_COMMON_IMPACT DESC;

# Q24 Identify the vehicle types that are most frequently involved in accidents where the driver's journey purpose is "Commuting to/from work."
SELECT VT.label AS VEHICLE, COUNT(*) AS ACCIDENT_COUNT
FROM VEHICLE_TYPES VT
LEFT JOIN VEHICLES V 
ON VT.code = V.Vehicle_Type
WHERE V.Journey_Purpose_of_Driver = 2
GROUP BY VEHICLE
ORDER BY ACCIDENT_COUNT DESC;

# Q25 Determine the vehicle type with the highest percentage of accidents occurring in rainy weather with high winds conditions.
SELECT V.Vehicle_Type,
COUNT(*) AS TOTAL_ACCIDENT,
 ROUND((COUNT(*) * 100.0 / (SELECT COUNT(*) FROM VEHICLES)),2) AS PERCENTAGE_OF_ACCIDENTS
FROM VEHICLES V 
LEFT JOIN ACCIDENTS A ON A.Accident_Index = V.Accident_Index
WHERE Weather_Conditions = 5
GROUP BY  V.Vehicle_Type
ORDER BY PERCENTAGE_OF_ACCIDENTS DESC;

# Q26 List the top 10 vehicle types with the highest engine capacity (CC) and the average age of vehicles for each type.
SELECT VT.label AS VEHICLE_TYPES,V.Engine_Capacity AS ENGINE_CAPACITY, ROUND(AVG(Age_of_Vehicle),2) AS AVG_AGE_VEHICLE
FROM VEHICLE_TYPES VT
LEFT JOIN VEHICLES V 
ON VT.code = V.Vehicle_Type
GROUP BY VEHICLE_TYPES,ENGINE_CAPACITY
ORDER BY AVG_AGE_VEHICLE DESC;

# Q27 Retrieve the percentage of accidents attended by the officer .
SELECT Did_Police_Officer_Attend_Scene_of_Accident, COUNT(*) AS COUNT, ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM ACCIDENTS),2) AS PERCENTAGE
FROM ACCIDENTS
GROUP BY Did_Police_Officer_Attend_Scene_of_Accident
ORDER BY PERCENTAGE DESC;

