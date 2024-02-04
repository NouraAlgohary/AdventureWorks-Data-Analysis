

CREATE VIEW [vw_DIM|Territory]
AS
SELECT [TerritoryID]
      ,[Name] [TerritoryName]
      ,[CountryRegionCode]
      ,[Group]
  FROM [Sales].[SalesTerritory] WITH(NOLOCK)