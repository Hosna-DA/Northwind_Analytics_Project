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
  CREATE PROCEDURE GetCustomerOrders


  
