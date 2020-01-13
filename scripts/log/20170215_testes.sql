-- Execute stored procedure B
DECLARE @OrderList OrderData;
INSERT @OrderList (OrderID, CustID, Freight) 
VALUES (1,2999,345.50)
,  (2,3000,120.00)
,  (3,3001, 70.50)
,  (4,3002, 12.50)
,  (5,3003,655.50) 
EXEC [dbo].[pAddOrders] @OrderList

select * FROM [DB_SISCOB_HML].[dbo].[Orders]


CREATE TABLE [dbo].[Orders] 
([OrderID] [int] NOT NULL,  
[CustID] [int] NOT NULL,  
[Freight] [money] NOT NULL,  
[OrderDate] [datetime] NOT NULL, 
CONSTRAINT [PK_orders] PRIMARY KEY CLUSTERED (  [OrderID] Asc ))  
GO  
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [DF_Orders_OrderDate] 
DEFAULT (geTdate()) FOR [OrderDate] 
GO