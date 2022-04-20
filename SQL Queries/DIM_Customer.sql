--Clean Customer Data
SELECT 
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
