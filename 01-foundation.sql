USE Northwind
GO

-- Question 1: Which products currently have zero units in stock?

SELECT
    ProductName,
    ProductID
FROM dbo.Products
WHERE UnitsInStock = 0;
GO


-- Question 2: List all customers based in a specific country,
-- sorted alphabetically by company name.

SELECT *
FROM dbo.Customers
WHERE Country = 'Germany'
ORDER BY CompanyName;
GO


-- Question 3: What are the 10 most expensive products in the catalog?

SELECT TOP 10
    ProductName,
    ProductID,
    UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;
GO


-- Question 4: Which product categories exist, listed without duplicates?

SELECT DISTINCT
    CategoryID
FROM dbo.Products;
GO