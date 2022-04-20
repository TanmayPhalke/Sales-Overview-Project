# Sales Overview Project

Business Request & User Stories
The business request for this data analyst project was an executive sales report for sales managers. Based on the request that was made from the business we following user stories were defined to fulfill delivery and ensure that acceptance criteria’s were maintained throughout the project.

|#|As a (role)|I want (request / demand)|So that I (user value)|Acceptance Criteria|
|-|-----------|:-------------------------:|:----------------------:|:-------------------:|
|1|Sales Manager|To get a dashboard overview of internet sales|Can follow better which customers and products sells the best|	A Power BI dashboard which updates data once a day|
|2|Sales Representative|A detailed overview of Internet Sales per Customers|Can follow up my customers that buys the most and who we can sell more to|	A Power BI dashboard which allows me to filter data for each customer
|3|Sales Representative|A detailed overview of Internet Sales per Products|Can follow up my Products that sells the most|	A Power BI dashboard which allows me to filter data for each Product|
|4|Sales Manager|A dashboard overview of internet sales|Follow sales over time against budget|	A Power BI dashboard with graphs and KPIs comparing against budget.|


**Data Cleansing & Transformation (SQL)**

To create the necessary data model for doing analysis and fulfilling the business needs defined in the user stories the following tables were extracted using SQL.

One data source (sales budgets) were provided in Excel format and were connected in the data model in a later step of the process.

Below are the SQL statements for cleansing and transforming necessary data.

**DIM Calender:**

`SELECT 
  [DateKey], 
  [FullDateAlternateKey] AS Date, 
  [EnglishDayNameOfWeek] AS Day, 
  [WeekNumberOfYear] AS WeekNum,
  [EnglishMonthName] AS Month, 
  LEFT([EnglishMonthName],3) AS MonthShort,
  [MonthNumberOfYear] AS MonthNum, 
  [CalendarQuarter] AS Quarter, 
  [CalendarYear] AS Year
FROM 
  [AdventureWorksDW2019].[dbo].[DimDate]
WHERE
  CalendarYear >= 2019
`

**DIM Customer:**

`SELECT 
  [CustomerKey] AS [Customer Key], 
  C.[FirstName] AS [First Name], 
  [LastName] AS [Last Name], 
  [BirthDate] AS [BirthDate], 
  CASE C.MaritalStatus WHEN 'M' THEN 'Married' WHEN 'S' THEN 'Single' END AS [Marital Status], 
  CASE C.Gender WHEN 'M' THEN 'Male' WHEN 'F' THEN 'Female' END AS [Gender], 
  [YearlyIncome] AS AnnualIncome, 
  [TotalChildren], 
  [EnglishEducation] AS Education, 
  [EnglishOccupation] AS Occupation, 
  CASE C.HouseOwnerFlag WHEN 1 THEN 'YES' WHEN 0 THEN 'NO' END AS [House Owner], 
  [NumberCarsOwned] AS NoOfCars, 
  [DateFirstPurchase], 
  [CommuteDistance], 
  g.City AS CustomerCity 
FROM 
  dbo.DimCustomer c 
  LEFT JOIN dbo.DimGeography as g ON g.GeographyKey = c.GeographyKey 
ORDER BY 
  CustomerKey ASC;
`

**DIM Products:**

`SELECT 
  p.[ProductKey], 
  p.[ProductAlternateKey] AS ProductItemCode, 
  p.[EnglishProductName] AS [Product Name], 
  ps.EnglishProductSubcategoryName AS [Sub Category], 
  pc.EnglishProductCategoryName AS [Product Category],
  p.[Color] as [Product Color],
  p.[Size] AS [Product Size],
  p.[ProductLine] AS [Product Line],
  p.[ModelName] AS [Product Model Name], 
  p.[EnglishDescription] AS [Product Description],
  ISNULL(p.[Status], 'Outdated') AS [Product Status] 
FROM 
  dbo.DimProduct p 
  LEFT JOIN dbo.DimProductSubcategory as ps ON ps.ProductSubcategoryKey = p.ProductSubcategoryKey 
  LEFT JOIN dbo.DimProductCategory as pc ON ps.ProductCategoryKey = pc.ProductCategoryKey 
ORDER BY 
  p.ProductKey;
`

**FACT_InternetSales:**

`SELECT 
  s.[ProductKey], 
  s.[OrderDateKey], 
  s.[DueDateKey], 
  s.[ShipDateKey], 
  s.[CustomerKey], 
  s.[SalesTerritoryKey], 
  st.SalesTerritoryCountry, 
  s.[SalesOrderNumber], 
  s.[SalesAmount] 
FROM 
  dbo.FactInternetSales s 
  JOIN dbo.DimSalesTerritory st on s.SalesTerritoryKey = st.SalesTerritoryKey 
WHERE 
  LEFT(s.OrderDateKey, 4) >= YEAR(GETDATE())-2 --to get data only 2 years before data extraction
ORDER BY 
  OrderDateKey ASC;
`


**Data Model**

Below is a screenshot of the data model after cleansed and prepared tables were read into Power BI.

This data model also shows how FACT_Budget hsa been connected to FACT_InternetSales and other necessary DIM tables.

![alt Sales Data Model Image](https://github.com/TanmayPhalke/Sales-Overview-Project/blob/main/Images/Sales%20Data%20Model.PNG)

