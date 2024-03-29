CREATE VIEW [vw_DIM|SalesPerson]
AS
SELECT [BusinessEntityID] [SalesPersonId]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
      ,[JobTitle]
      ,[PhoneNumber]
      ,[PhoneNumberType]
      ,[EmailAddress]
      ,[AddressLine1]
      ,[City]
      ,[StateProvinceName]
      ,[PostalCode]
      ,[CountryRegionName]
      ,[TerritoryName]
      ,[TerritoryGroup]
  FROM [Sales].[vSalesPerson]