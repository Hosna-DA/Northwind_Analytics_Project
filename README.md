# Northwind Analytics Project

**Author:** Hosna Hassanzadeh
### 📄 [Schema Report](./Project_Details/schema-report.md)
A comprehensive study of the Northwind Traders database, demonstrating SQL development from foundational queries to advanced, reusable analytical components.

## Environment & Tools
-**Database Engine:** Microsoft SQL Server 2022 (Standard Edition)
- **Client/Interface:** SQL Server Management Studio (SSMS)

## Repository Structure
- `01-foundation/`: Basic SELECT statements, filtering, and sorting--> Learned to filter, sort, and select distinct data using WHERE, ORDER BY, TOP, and DISTINCT.
- `02-Joins/`: Multi-table relations (INNER, LEFT, RIGHT)-->Learned to combine data across multiple tables using INNER JOIN and LEFT JOIN, including handling unmatched rows.
- `03-Aggregation/`: Grouping data and summary statistics-->Learned to summarize data with GROUP BY, HAVING, and aggregate functions like SUM, COUNT, and AVG.
- `04-SUBQUERIES & CTES/`: Complex logic and query optimization-->Learned to break complex logic into readable steps using WITH (CTEs) and subqueries, and to compare individual rows against group-level aggregates.
- `05-WindowFunction-->Learned to rank, calculate running totals, and compare rows to previous periods using RANK, LAG, and OVER (PARTITION BY ...) — without collapsing the underlying rows the way GROUP BY does.
- `06-Reusable Building Blocks/`: Views, Stored Procedures, and modular design-->Learned to package reusable logic into VIEWs and parameterized STORED PROCEDUREs, and understood the basics of indexing for performance.
- `07-Business Case Studies — Think Like an Analyst-->Learned to translate raw SQL output into plain-language business recommendations — going beyond "what does the data say" to "what should the company do about it."
- `Project_Details/`: Documentation and database files.
## Key Business Insights

1. **Market reliability matters more than raw averages.** Austria and Ireland 
   showed the highest average order values, but this came from a sample of 
   just 1–2 customers each — too small to be a reliable signal. The USA and 
   Germany, despite lower averages, showed far more stable performance across 
   11–13 customers, making them stronger candidates for continued or increased 
   investment.

2. **Three products show genuine weak demand, not a supply problem.** 
   Chocolade, Gravad lax, and Genen Shouyu combine the lowest revenue and 
   order counts in the catalog with healthy stock levels (11–39 units) — 
   ruling out "out of stock" as the cause. This makes them the safest 
   discontinuation candidates without risking loss of high-demand products.
   
3. **Revenue is heavily concentrated in a small customer base.** The top 10 
   customers account for roughly 45% of total company revenue, with the top 
   3 alone (QUICK-Stop, Ernst Handel, Save-a-lot Markets) contributing about 
   25%. This concentration is a meaningful business risk — losing even one 
   or two of these top accounts could materially impact revenue — and 
   suggests the company should prioritize retention programs for its 
   highest-value customers while also working to diversify its customer base.
## Database Schema
```mermaid
erDiagram
CUSTOMERS ||--o{ ORDERS : places
EMPLOYEES ||--o{ ORDERS : manages
SHIPPERS ||--o{ ORDERS : ships
ORDERS ||--|{ ORDER_DETAILS : contains
PRODUCTS ||--o{ ORDER_DETAILS : includes
CATEGORIES ||--o{ PRODUCTS : categorizes
SUPPLIERS ||--o{ PRODUCTS : supplies

CUSTOMERS {
string CustomerID PK
string CompanyName
string ContactName
string City
string Country
}

ORDERS {
int OrderID PK
string CustomerID FK
int EmployeeID FK
datetime OrderDate
datetime RequiredDate
datetime ShippedDate
int ShipVia FK
decimal Freight
string ShipName
string ShipCity
string ShipCountry
}

ORDER_DETAILS {
int OrderID PK, FK
int ProductID PK, FK
decimal UnitPrice
smallint Quantity
float Discount
}

PRODUCTS {
int ProductID PK
string ProductName
int SupplierID FK
int CategoryID FK
string QuantityPerUnit
decimal UnitPrice
smallint UnitsInStock
smallint UnitsOnOrder
bit Discontinued
}

CATEGORIES {
int CategoryID PK
string CategoryName
string Description
}

SUPPLIERS {
int SupplierID PK
string CompanyName
string ContactName
string City
string Country
}

EMPLOYEES {
int EmployeeID PK
string LastName
string FirstName
string Title
datetime BirthDate
datetime HireDate
string City
string Country
}
