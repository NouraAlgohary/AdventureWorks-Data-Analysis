CREATE VIEW [vw_Fact|OrderDetails]
AS
SELECT SOD.[SalesOrderID]
      ,SOD.[SalesOrderDetailID]      
      ,SOD.[OrderQty]
      ,SOD.[ProductID]
      ,SOD.[UnitPrice]
      ,SOD.[LineTotal]
	  ,CAST(FORMAT(SOH.[OrderDate] ,'yyyyMMdd') AS INT) [OrderDateKey]
	  ,CAST(FORMAT(SOH.[DueDate] ,'yyyyMMdd') AS INT) [DueDateKey]
	  ,CAST(FORMAT(SOH.[ShipDate] ,'yyyyMMdd') AS INT) [ShipDateKey]
      ,SOH.[Status] [StatusId]
      ,SOH.[OnlineOrderFlag]
      ,SOH.[SalesPersonID]
      ,SOH.[TerritoryID]
      ,SOH.[ShipMethodID]
      ,(SOD.[LineTotal]/ SOH.[SubTotal]) * SOH.[TaxAmt] [Taxamt]
	  ,(SOD.[LineTotal]/ SOH.[SubTotal]) * SOH.[Freight] [Freight]
	  ,(SOD.[LineTotal]/ SOH.[SubTotal]) * SOH.[TotalDue] [TotalDue]
  FROM [Sales].[SalesOrderDetail] SOD WITH(NOLOCK)
  LEFT JOIN [Sales].[SalesOrderHeader] SOH WITH(NOLOCK)
  ON SOD.SalesOrderID = SOH.SalesOrderID