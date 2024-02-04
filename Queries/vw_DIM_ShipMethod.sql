CREATE VIEW [vw_DIM|ShipMethod]
AS
SELECT [ShipMethodID]
      ,[Name] [ShipMethod] 
  FROM[Purchasing].[ShipMethod] WITH(NOLOCK)