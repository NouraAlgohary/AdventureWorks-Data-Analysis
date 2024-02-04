

CREATE VIEW [vw_DIM|Product]
AS
SELECT P.[ProductID]
      ,P.[Name] [ProductName]
      ,P.[ProductNumber]
      ,P.[Color]
      ,P.[ReorderPoint]
      ,P.[StandardCost]
      ,P.[ListPrice]
      ,P.[Weight]
      ,P.[ProductLine]
      ,P.[Class]
      ,P.[Style]
      ,P.[ProductSubcategoryID]
	  ,PSC.[ProductCategoryID]
      ,PSC.[Name] [SubCategoryName]
      ,PC.[Name] [CategoryName]
  FROM [Production].[Product] P WITH (NOLOCK)  
  LEFT JOIN [Production].[ProductSubcategory] PSC WITH (NOLOCK)
  ON P.ProductSubcategoryID = PSC.ProductSubcategoryID
  LEFT JOIN [Production].[ProductCategory] PC WITH(NOLOCK)
  ON PSC.ProductCategoryID = PC.ProductCategoryID
