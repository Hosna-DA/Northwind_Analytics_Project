--LEVEL7:Business Case Studies — Think Like an Analyst
USE Northwind
GO
--Question1:Who are the top 10 customers by lifetime revenue, and what share of total revenue do they represent?
WITH T AS (
SELECT SUM(UnitPrice * Quantity * (1 - Discount)) AS TotalRevenue
FROM dbo.[Order Details]
)
SELECT TOP 10 
   C.CustomerID,
   CompanyName,
   ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)),2)AS TotalSpent,
  CONVERT(nvarchar,ROUND(SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount) )/(SELECT TotalRevenue
                                                          FROM T) * 100 ,2))+ '%'  AS PercentageOfTheTotalAmount
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
  ON C.CustomerID=O.CustomerID
LEFT JOIN dbo.[Order Details] AS OD
  ON O.OrderID=OD.OrderID
GROUP BY C.CustomerID,CompanyName
ORDER BY SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount) ) DESC
GO

--Question2:What is the month-over-month revenue growth trend for the most recent full year of data?
SELECT *
FROM dbo.Orders
ORDER BY OrderDate DESC
GO
--1997 is the most recent full year of data
WITH MonthlyRevenue AS(
SELECT 
  MONTH(Orderdate) AS MonthOf1997,
  ROUND(SUM(Quantity*Unitprice*(1-discount)),2) AS TotalRevenue
FROM dbo.Orders AS O
JOIN dbo.[Order Details] AS OD
   ON O.OrderID=OD.OrderID
WHERE YEAR(OrderDate) = 1997
GROUP BY MONTH(Orderdate) 

)
SELECT MonthOf1997,
       TotalRevenue,
	   LAG(TotalRevenue) OVER (ORDER BY MonthOf1997) AS LASTRevenue,
	   CONVERT(nvarchar,ROUND ((TotalRevenue -(LAG(TotalRevenue) OVER (ORDER BY MonthOf1997))) /(LAG(TotalRevenue) OVER (ORDER BY MonthOf1997))* 100,2) )+ '%' AS GrowthPercent
	   --(TotalRevenue - LASTRevenue) / LASTRevenue * 100
FROM MonthlyRevenue
GO

--Question3:Which employees are the top performers by revenue, and does their strength vary by product category?

SELECT 
   E.EmployeeID,
    E.FirstName + ' ' + E.LastName AS EmployeeName,
   C.CategoryID,
   CategoryName,
   ROUND(SUM(Quantity * OD.UnitPrice * (1-Discount)),2) AS Revenue
FROM dbo.Employees AS E
LEFT JOIN dbo.Orders AS O
 ON E.EmployeeID = O.EmployeeID
JOIN dbo.[Order Details] AS OD
 ON OD.OrderID=O.OrderID
JOIN dbo.Products AS P
 ON P.ProductID=OD.ProductID
 JOIN dbo.Categories AS C
  ON P.CategoryID = C.CategoryID
 GROUP BY C.CategoryID,E.EmployeeID,CategoryName,E.FirstName,E.LastName
 ORDER BY E.EmployeeID,C.CategoryID 
GO

--Question4:Which customers haven't ordered in the last 6 months, and should be flagged as at risk of churning?
SELECT 
   C.CustomerID,
   CompanyName,
   MAX(OrderDate) AS LastOrderDate
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
  ON O.CustomerID=C.CustomerID
GROUP BY C.CustomerID,CompanyName
HAVING MAX(ORDERDATE) < DATEADD(MONTH, -6, (SELECT MAX(OrderDate) FROM dbo.Orders))  OR MAX(ORDERDATE) IS NULL
GO

--Question5: Which country generates the highest average order value, and is that a market worth investing more in?
WITH OrdersRevenue AS(
SELECT
     O.OrderID,
	 Country,
    SUM(Quantity * UnitPrice * (1-Discount)) AS Revenue,
	C.CustomerID
FROM dbo.Customers AS C
LEFT JOIN dbo.Orders AS O
  ON C.CustomerID=O.CustomerID
JOIN dbo.[Order Details] AS OD
  ON OD.OrderID = O.OrderID
GROUP BY O.OrderID,Country,C.CustomerID
)
SELECT TOP 5
       Country,
	   ROUND(AVG(Revenue),2) AS [Avrage Of Revenues],
	   COUNT(distinct(CustomerID)) AS RangeOFCustomers
FROM OrdersRevenue
GROUP BY Country
ORDER BY AVG(Revenue) DESC ,COUNT(distinct(CustomerID)) DESC
 -->Austria and Ireland show the highest average order values, but this figure comes from a very
 --small sample (only 1–2 customers each) and isn't reliable for major investment decisions.
 --In contrast, the USA and Germany, despite lower averages, show a more stable and trustworthy pattern due to their larger customer base (13 and 11 customers respectively)
 --these markets(USA and Germany) are better candidates for increased investment, since their performance doesn't depend on the behavior of just one or two customers.
GO

--Question6:If the company had to discontinue three products based on the data alone, which would you recommend, and why?

SELECT 
    P.ProductID,
    P.ProductName,
	UnitsInStock,
	COUNT(OrderID) AS CountsOfOrders,
    ROUND(SUM(Quantity * OD.UnitPrice * (1-Discount)),2) AS TotalRevenue
FROM dbo.Products AS P
LEFT JOIN dbo.[Order Details] AS OD
    ON P.ProductID = OD.ProductID
GROUP BY P.ProductID,P.ProductName,UnitsInStock
ORDER BY COUNT(OrderID) ASC,UnitsInStock ASC,TotalRevenue ASC 
-->Based on total revenue, order count, and current stock levels, three products stand out as strong candidates for discontinuation:
--Chocolade, Gravad lax, and Genen Shouyu
--All three combine very low order counts (6 orders each) with the lowest revenue figures in the catalog, while still holding meaningful stock (11–39 units) — ruling out "temporarily out of stock" as an explanation.
--This pattern points to genuinely weak customer demand rather than a supply issue, making these products the safest candidates to cut without risking the loss of high-value, high-demand items.
GO


