SELECT 
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
