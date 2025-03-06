--1. Create a new table in TakYak database:
USE TakYak
Create Table Ad_Campaigns
(Ad_Group varchar(255) PRIMARY KEY
,Clicks INT)

--2. Insert CSV File from Excel into Ad_Campaigns table:
BULK INSERT Ad_Campaigns
FROM 'C:\Users\Molly\OneDrive\Documents\TakYakAdGroup.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,  -- Skip header row
    FIELDTERMINATOR = ',',  -- Define column separator
    ROWTERMINATOR = 'r\n',   -- Define row separator for Windows
    TABLOCK)	--prevents other queries from modifying table during insert

--3. Rename Table Ad_Campaigns to OneDeal_AdGroups
EXEC sp_rename 'Ad_Campaigns', 'OneDeal_AdGroups'

