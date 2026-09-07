--LEVEL2:This section is about Joins — Connecting the Tables
USE Northwind
GO
--Question1:for every order,show the cutomer's company name and the employee who processed it
SELECT
O.OrderID,
C.CompanyName,
C.ContactName
FROM dbo.Orders AS O
INNER JOIN dbo.Customers AS C
  ON O.CustomerID=C.CustomerID
ORDER BY OrderID
GO
--Question2:For every product,show its category name and its supplier's name in one row
SELECT
P.ProductName,
C.CategoryName,
S.CompanyName AS "Supplier Company"
FROM dbo.Products AS P
LEFT JOIN dbo.Categories AS C
   ON P.CategoryID=C.CategoryID
LEFT JOIN dbo.Suppliers AS S
   ON S.SupplierID=P.SupplierID
GO
--Question3:Which customers have never placed single order?
SELECT 
C.CustomerID,
C.CompanyName AS "SupplierCompany",
O.OrderID
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
  ON C.CustomerID=O.CustomerID
WHERE OrderID IS NULL
GO
--Question4:For every order,show which shipping company deliverd it.
SELECT 
O.OrderID,
S.CompanyName AS "shipping company"
FROM dbo.Orders AS O
JOIN dbo.Shippers AS S
  ON S.ShipperID=O.ShipVia
GO