SELECT 
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
