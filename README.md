# U.K-Road-Accident-Data-Analysis
This GitHub repository contains an analysis of  U.K's Road Accident data using SQL. The dataset includes information on various aspects like vehicles, light conditions etc. The goal of this project is to explore and gain insights from the data .
The data is sourced from https://www.data.gov.uk/dataset/cb7ae6f0-4be6-4935-9277-47e5ce24a11f/road-safety-data

Tables
1) Accidents : This table contains information about accidents, including accident location, severity, number of vehicles and casualties, date and time, road conditions, and more.
Columns:
Accident_Index: Unique identifier for each accident
Location_Easting_OSGR: Easting coordinate of the accident location
Location_Northing_OSGR: Northing coordinate of the accident location
Longitude: Longitude of the accident location
Latitude: Latitude of the accident location
Police_Force: The police force attending the accident
Accident_Severity: Severity of the accident
Number_of_Vehicles: Number of vehicles involved in the accident
Number_of_Casualties: Number of casualties in the accident
Date: Date of the accident
Day_of_Week: Day of the week when the accident occurred
Time: Time of the accident
Local_Authority_(District): Local authority district where the accident occurred
Local_Authority_(Highway): Local authority highway code
1st_Road_Class: Class of the first road
1st_Road_Number: Number of the first road
Road_Type: Type of road
Speed_limit: Speed limit on the road
Junction_Detail: Details about the junction
Junction_Control: Control at the junction
2nd_Road_Class: Class of the second road
2nd_Road_Number: Number of the second road
Pedestrian_Crossing-Human_Control: Control at pedestrian crossings
Pedestrian_Crossing-Physical_Facilities: Facilities at pedestrian crossings
Light_Conditions: Light conditions at the time of the accident
Weather_Conditions: Weather conditions at the time of the accident
Road_Surface_Conditions: Road surface conditions at the time of the accident
Special_Conditions_at_Site: Special conditions at the accident site
Carriageway_Hazards: Hazards on the carriageway
Urban_or_Rural_Area: Whether the accident occurred in an urban or rural area
Did_Police_Officer_Attend_Scene_of_Accident: Whether a police officer attended the scene
LSOA_of_Accident_Location: Lower-layer super output area of the accident location

2)Vehicles : This table contains information about the vehicles involved in each accident, including vehicle type, maneuver, driver details, and more.
Columns:
Accident_Index: Unique identifier linking to the accident
Vehicle_Reference: Unique identifier for each vehicle involved
Vehicle_Type: Type of vehicle
Towing_and_Articulation: Towing and articulation details
Vehicle_Manoeuvre: Maneuver performed by the vehicle
Vehicle_Location-Restricted_Lane: Location of the vehicle in restricted lanes
Junction_Location: Location of the vehicle at the junction
Skidding_and_Overturning: Skidding and overturning information
Hit_Object_in_Carriageway: Object hit in the carriageway
Vehicle_Leaving_Carriageway: Details about the vehicle leaving the carriageway
Hit_Object_off_Carriageway: Object hit off the carriageway
1st_Point_of_Impact: First point of impact on the vehicle
Was_Vehicle_Left_Hand_Drive?: Whether the vehicle is left-hand drive
Journey_Purpose_of_Driver: Purpose of the driver's journey
Sex_of_Driver: Gender of the driver
Age_of_Driver: Age of the driver
Age_Band_of_Driver: Age band of the driver
Engine_Capacity_(CC): Engine capacity of the vehicle
Propulsion_Code: Propulsion code of the vehicle
Age_of_Vehicle: Age of the vehicle
Driver_IMD_Decile: Driver's Index of Multiple Deprivation (IMD) decile
Driver_Home_Area_Type: Home area type of the driver
Vehicle_IMD_Decile: Vehicle's Index of Multiple Deprivation (IMD) decile

3)Vehicle_Types:- This table provides a mapping of vehicle type codes to labels for easy interpretation of vehicle types in the "Vehicles" table.
Columns:
code: Vehicle type code
label: Descriptive label for the vehicle type
Data Source

