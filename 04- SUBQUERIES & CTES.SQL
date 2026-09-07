--LEVEL4:This section is about Subqueries & CTEs — Queries Inside Queries
USE Northwind
GO
-- Question1: Which customers spend more than the average customer?

SELECT 
    CustomerID, 
    SUM(Quantity * UnitPrice) AS TotalSpent
FROM dbo.[Order Details] AS OD
JOIN dbo.Orders AS O ON OD.OrderID = O.OrderID
GROUP BY CustomerID
HAVING SUM(Quantity * UnitPrice) > (
    -- Subquery: 
    SELECT AVG(CustomerTotal)
    FROM (
        SELECT SUM(Quantity * UnitPrice) AS CustomerTotal
        FROM dbo.[Order Details] AS OD2
        JOIN dbo.Orders AS O2 ON OD2.OrderID = O2.OrderID
        GROUP BY O2.CustomerID
    ) AS SubTable
)
ORDER BY TotalSpent DESC
GO
--QUESTION2:What are the 3 best-selling products overall, by total revenue?
      SELECT TOP 3
	    OD.ProductID,
		P.ProductName,
	    SUM(OD.Quantity * OD.UnitPrice) AS TotalAmount
      FROM dbo.[Order Details] AS OD
	  JOIN dbo.Products AS P
	   ON P.ProductID=OD.ProductID
	 GROUP BY OD.ProductID,P.ProductName
	 ORDER BY TotalAmount DESC
GO
--Using a CTE, what is the best-selling product within each category
WITH ProductRevenue AS (
    SELECT 
        P.CategoryID,
        OD.ProductID,
        SUM(OD.Quantity * OD.UnitPrice) AS TotalAmount
    FROM dbo.[Order Details] AS OD
    JOIN dbo.Products AS P
        ON OD.ProductID = P.ProductID
    GROUP BY P.CategoryID, OD.ProductID
),
CategoryBest AS (
    SELECT 
        CategoryID,
        MAX(TotalAmount) AS MaxAmount
    FROM ProductRevenue
    GROUP BY CategoryID
)
  SELECT 
    CB.CategoryID,
    P.ProductName,
    PR.TotalAmount AS Revenue
  FROM CategoryBest AS CB
  JOIN ProductRevenue AS PR
    ON CB.CategoryID = PR.CategoryID
   AND CB.MaxAmount = PR.TotalAmount
  JOIN dbo.Products AS P
    ON PR.ProductID = P.ProductID
  ORDER BY CB.CategoryID;


--Which products are priced above the average price within their own category?
  SELECT *
  FROM dbo.Products AS P1
  WHERE UnitPrice>(select AVG(UnitPrice) 
                   FROM dbo.Products AS P2
				   WHERE P1.CategoryID=P2.CategoryID
				   ) 

                          

GO