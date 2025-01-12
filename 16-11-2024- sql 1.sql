SET SQL_SAFE_UPDATES = 0;
SELECT @@SQL_SAFE_UPDATES;

Create Schema Market_schema;
use Market_schema;

-- 1. Create a table 'shipping_mode_dimen' having columns with their respective data types as the following:
Create Table shipping_mode (Ship_Mode VARCHAR(25),
Vehicle_Company VARCHAR(25),
Toll_Required BOOLEAN);

--- 2. Make 'Ship_Mode' as the primary key in the above table.

ALTER  Table Shipping_mode
ADD PRIMARY KEY(Ship_mode);

-- DML Statements

-- 1. Insert two rows in the table created above having the row-wise values:
--    (i)'DELIVERY TRUCK', 'Ashok Leyland', false
--    (ii)'REGULAR AIR', 'Air India', false

Insert into Shipping_mode Values ('DELIVERY TRUCK', 'Ashok Leyland', false),('REGULAR AIR', 'Air India', false);

-- 2. The above entry has an error as land vehicles do require tolls to be paid. Update the ‘Toll_Required’ attribute
-- to ‘Yes’.

Update shipping_mode 
Set Toll_Required = True
where ship_mode= "Delevery_Truvk";

Insert into shipping_mode Values ('Express Van', 'Eicher', true),('Express Air', "Vistara", false), ('Regular Air', "Vista", false);



-- 3. Delete the entry for Air India.

delete from shipping_mode
where vehicle_company ='Air India';

-- Adding and Deleting Columns

-- 1. Add another column named 'Vehicle_Number' and its data type to the created table. 


-- 2. Update its value to 'MH-05-R1234'.


-- 3. Delete the created column.


alter table shipping_mode
add column Vechile_number Varchar(20);

Update shipping_mode 
Set Vechile_number = "MH-05-R1234"
where ship_mode= "Delevery_Truvk";