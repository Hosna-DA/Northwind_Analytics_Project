--LEVEL3:This section is about Aggregation — Summarizing the Data
USE Northwind
GO
--QUESTION1:What total revenue has each product category generated?
   SELECT 
     C.CategoryID,
	 CategoryName,
     sum(OD.unitprice * OD.Quantity) AS TotalRevenue	 
   FROM dbo.[Order Details] AS OD
   JOIN dbo.Products AS P
	 ON P.ProductID=OD.ProductID
   JOIN Categories AS C ON C.CategoryID=P.CategoryID
   GROUP BY C.CategoryID,C.CategoryName
   ORDER BY TotalRevenue DESC
GO

--Question2:How many Orders has each employee handled?
  SELECT 
   EmployeeID,
   count(orderid) AS "Amount Of Orders"
  FROM dbo.Orders
  GROUP BY EmployeeID
GO
--Question3:What is the average order value per customer?
WITH OrderTotal AS(
     SELECT  O.CustomerID,
	         O.OrderID,
			 SUM(UnitPrice*Quantity) AS OrderValue    
	 FROM dbo.[Order Details] AS OD
	 JOIN dbo.Orders AS O
		ON O.OrderID=OD.OrderID
	GROUP BY O.CustomerID,O.OrderID) 
SELECT      
        C.CustomerID,
		C.CompanyName,
	   AVG(OT.OrderValue) AS AvrageOrderValue 
FROM OrderTotal AS OT
JOIN dbo.Customers AS C
  ON C.CustomerID=OT.CustomerID
GROUP BY C.CustomerID,C.CompanyName 
ORDER BY AvrageOrderValue DESC
	    



    
 --Question4:Which categories contain more than 10 products?
   SELECT 
     P.CategoryID,
	 C.CategoryName,
	 Count(ProductID) AS "CountOfProducts"
   FROM dbo.Products AS P
   JOIN Categories AS C
    ON C.CategoryID=P.CategoryID
   GROUP BY P.CategoryID,C.CategoryName
   HAVING Count(ProductID)>10