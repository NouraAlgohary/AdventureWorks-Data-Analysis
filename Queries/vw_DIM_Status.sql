



CREATE VIEW [vw_DIM|Status]
AS
WITH CTE 
AS
(
SELECT 1 [StatusId], [dbo].[ufnGetSalesOrderStatusText](1) [StatusName]
UNION ALL
SELECT [StatusId] + 1, [dbo].[ufnGetSalesOrderStatusText]([StatusId] + 1) [StatusName]
FROM CTE
WHERE [StatusId] < 6
)
SELECT [StatusId], [StatusName]
FROM CTE