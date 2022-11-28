/**--List everything from data source
SELECT * From PortfolioProject..PinellasHousingData

--Filter data to Florida properties
Select owner1, owner2, address1, city, state, property_use_description, sale_date, price, qu, vi, year, land_size, unit_value
From PortfolioProject..PinellasHousingData
Where state like 'FL'**/

--Format data to be comprehensible. Also gets rid of any cities outside of Pinellas county.
Select owner1, address1, city, state, property_use_description, sale_date, price, qu As qualified_state, vi As vacant_state, year, land_size, unit_value
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'

--------------------Ordering Individual Columns----------------------------------------------------------------------------------------------------------
/**Table above, but ordered by date (earliest-latest)
Select owner1, address1, city, state, property_use_description, sale_date, price, qu As qualified_state, vi As vacant_state, year, land_size, unit_value
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Order by sale_date ASC;

--Table above, but ordered by sale price (lowest-highest)
Select owner1, address1, city, state, property_use_description, sale_date, price, qu As qualified_state, vi As vacant_state, year, land_size, unit_value
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Order by price ASC;

--Table above, but ordered by city (A-Z)
Select owner1, address1, city, state, property_use_description, sale_date, price, qu As qualified_state, vi As vacant_state, year, land_size, unit_value
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Order by city ASC;**/

----------Counting Individual Columns------------------------------------------------------------------------------------------------------------------
--Counts each qualified lot in each county
Select city, Count(qu) As qualified_state_total 
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M') 
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Group by city
Order by city ASC;

--Counts each vacant lot in each county
Select city, Count(vi) As vacant_state_total
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Group by city
Order by city ASC;

--Counts the total number of owners who are a corporation
Select COUNT(owner1) As llc_owner 
From PortfolioProject..PinellasHousingData
Where 
	owner1 like '%LLC' 
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'

--Counts the total number of owners who are an individual
Select COUNT(owner1) As in_owner
From PortfolioProject..PinellasHousingData
Where 
	owner1 not like '%LLC' 
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'

-------Minimum and Maximum Prices in Pinellas County by year----------------------------------------------------------------------------------------------
--Minimum and Maximum price for each property in Pinellas
Select MIN(price) As min_price, MAX(price) As max_price, year
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Group by year

--Minimum and Maximum Prices for Single Family Homes
Select MIN(price) As min_price, MAX(price) As max_price, year
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
	And property_use_description like 'Single Family%'
Group by year

--Minimum and Maximum prices for Duplex, Triplex, and Quaplex Houses
Select MIN(price) As min_price, MAX(price) As max_price, year
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
	And property_use_description like 'Duplex%'
Group by year

---------------Agg. Values-----------------------------------------------------------------------------------------------------------------------
/**Average price and unit value for Pinellas county in general
Select AVG(price) As avg_price, AVG(unit_value) As avg_unit_value
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'**/

--Average price and unit value for each city in Pinellas
Select AVG(price) As avg_price, AVG(unit_value) As avg_unit_value, city
From PortfolioProject..PinellasHousingData
Where 
	state like 'FL' 
	And qu not In ('U', 'M')
	And vi not like ''
	And city not In ('The Villages', 'Odessa', 'Dania Beach', 'Jacksonville', 'Ozona', 'Sarasota', 'Tampa', 'Davenport', 'Englewood')
	And land_size not like '0x0'
Group by city

