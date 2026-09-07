--LEVEL3:This section is about Aggregation — Summarizing the Data
USE Northwind
GO
--QUESTION1:What total revenue has each product category generated?
   SELECT 
     O.ProductID,
     sum(O.unitprice) AS "total revenue",
     CategoryName
   FROM dbo.[Order Details] AS O
   JOIN(SELECT ProductID,CategoryID
     FROM dbo.Products) AS P
	 ON P.ProductID=O.ProductID
   JOIN Categories AS C ON C.CategoryID=P.CategoryID
   GROUP BY O.ProductID,CategoryName
GO

--Question2:How many Orders has each employee handled?
  SELECT 
   EmployeeID,
   count(orderid) AS "Amount Of Orders"
  FROM dbo.Orders
  GROUP BY EmployeeID
GO
--Question3:What is the average order value per customer?
      SELECT 
	   C.CustomerID,
	   C.CompanyName AS "CustomerCompany",
	   avg(UnitPrice*Quantity) AS "Avarage Value Of Each Customer"
      FROM dbo.[Order Details] AS OI
	  JOIN ( SELECT OrderID,CustomerID
	         FROM dbo.Orders) AS O
		ON O.OrderID=OI.OrderID
	 JOIN dbo.Customers AS C
	    ON C.CustomerID=O.CustomerID
	GROUP BY C.CustomerID , C.CompanyName
	Order by [Avarage Value Of Each Customer] DESC
 GO
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