--LEVEL5:This section is about Window Functions — Ranking and Trends
USE Northwind
GO
--Question1:Rank all customers by total spending, from highest to lowest.

  WITH CustomerSpending AS(
  SELECT
    O.CustomerID,
    Sum(Quantity*UnitPrice) AS "TotalSpent"
  FROM dbo.[Order Details] AS OD
  JOIN(SELECT OrderID,CustomerID
       FROM dbo.Orders) AS O
    ON OD.OrderID=O.OrderID
  GROUP BY O.CustomerID)

  SELECT
      CustomerID,
      TotalSpent,
	  RANK() OVER(ORDER BY TotalSpent DESC) AS SpentRank
  FROM CustomerSpending
GO

--Question2:Calculate a running total of monthly revenue across the full order history.
WITH MonthlyRevenue AS (
  SELECT
    FORMAT(O.OrderDate,'yyyy_MM') AS OrderMonth,
	SUM(OD.Quantity*OD.UnitPrice) AS MonthlyRevenue
  FROM dbo.Orders AS O 
  LEFT OUTER JOIN dbo.[Order Details] AS OD
    ON OD.OrderID=O.OrderID
  GROUP BY FORMAT(O.OrderDate,'yyyy_MM')
  )
 SELECT	
    OrderMonth,
	MonthlyRevenue,
	SUM(MonthlyRevenue) OVER(ORDER BY OrderMonth) AS RuningTotal 
FROM MonthlyRevenue;
--QUESTION3:For each month, how does revenue compare to the previous month
 WITH Revenue AS(
  SELECT
	FORMAT(O.OrderDate,'yyyy_MM') AS OrderMonth,
	Sum(OD.UnitPrice*OD.Quantity) AS MonthRevenue
  FROM dbo.[Orders] AS O 
  LEFT OUTER JOIN dbo.[Order Details] AS OD
    ON OD.OrderID=O.OrderID
  GROUP BY FORMAT(O.OrderDate,'yyyy_MM')  )

 SELECT 
     OrderMonth,
	 LAG(MonthRevenue) OVER (ORDER BY FORMAT(OrderMonth)) AS PreRevenue,
	 MonthRevenue
  FROM Revenue
GO
--What are the top 2 products by revenue within each category?
WITH Product AS( 
 SELECT
  ProductID,
  ProductName,
  RANK() OVER(PARTITION BY P.CategoryID
              ORDER BY UnitPrice) AS PriceRank,
  CategoryName
FROM dbo.Products AS P
JOIN dbo.Categories AS C
 ON C.CategoryID=P.CategoryID)

 SELECT *
 FROM Product
 WHERE PriceRank<=2
