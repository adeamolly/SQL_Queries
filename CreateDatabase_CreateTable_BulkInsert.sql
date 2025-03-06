--1. Create a new database:
CREATE DATABASE TakYak

--2. Create a new table:
CREATE TABLE Orders
(
Order_Number INT NOT NULL PRIMARY KEY
	,Order_Date DATE, NULL
	,Attribution varchar(20) NOT NULL
	,Subtotal DECIMAL(18,0) NOT NULL
	,Total_ol_Discount DECIMAL(18,0) NOT NULL
	,Discounts DECIMAL(18,0) NOT NULL
	,Shipping DECIMAL(18,0) NOT NULL
	,Tax DECIMAL(18,0) NOT NULL
	,Total AS (
        COALESCE(Subtotal, 0) - COALESCE(Total_ol_Discount, 0) - COALESCE(Discounts, 0) + COALESCE(Shipping, 0) + COALESCE(Tax, 0)
    ) PERSISTED		--COALESCE(column,0) ensures NULL values are treated as 0 to avoid errors
)					--PERSISTED ensures the computed value is stored in the database and not calculated on the fly, can be indexed for performance improvements

--3. Insert CSV file from Excel into Orders table:
BULK INSERT Orders
FROM 'C:\Users\Molly\OneDrive\Documents\TakYakOrders.csv' --path of CSV File from Excel
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,  -- Skip header row
    FIELDTERMINATOR = ',',  -- Define column separator
    ROWTERMINATOR = 'r\n',   -- Define row separator for Windows
    TABLOCK)	--prevents other queries from modifying table during insert