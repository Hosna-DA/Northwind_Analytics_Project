--LEVEL6:This section is about Reusable Building Blocks
USE Northwind
GO
--Question1:Create a view that shows every order line with the customer name and product name already joined in
CREATE VIEW NewOrderDetails as 
SELECT
 O.OrderID,
 C.CompanyName,
 P.ProductName

 FROM dbo.Orders AS O
 JOIN dbo.Customers AS C
    ON O.CustomerID=C.CustomerID
 JOIN dbo.[Order Details] AS OD
  ON O.OrderID=OD.OrderID
 JOIN dbo.Products AS P
  ON OD.ProductID=P.ProductID
  GO
  SELECT * FROM NewOrderDetails WHERE CompanyName ='Ernst Handel'
GO

--Question2:Create a stored procedure that returns all orders for a given CustomerID, passed in as a parameter.
CREATE  PROCEDURE OrderDetail
     @CustomerID nchar(10)
AS
BEGIN
 SELECT *
 FROM dbo.Orders
 WHERE @CustomerID = CustomerID
END;
GO
--Question3:Create a stored procedure that accepts a start and end date and returns total revenue for that range.
CREATE PROCEDURE GetTotalRevenueByDateRange
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS TotalRevenue
    FROM dbo.[Order Details] AS OD
    JOIN dbo.Orders AS O ON OD.OrderID = O.OrderID
    WHERE O.OrderDate >= @StartDate AND O.OrderDate <= @EndDate;
END;
GO
--Question4:Which column would benefit most from an index if this database had millions of orders, and why?
--1. CustomerID
--Why: You often search for all orders belonging to one specific customer.
--Benefit: It makes the search instant. Without this index, the database must scan the entire table row by row, which is very slow.

--2. OrderDate
--Why: You often need reports for specific time periods (e.g., “orders in 2025” or “last month”).
--Benefit: It keeps the dates sorted chronologically. The database can quickly jump to the right timeframe instead of checking every single order in the history.




  
