# Northwind Analytics Project

**Author:** Hosna Hassanzadeh

A comprehensive study of the Northwind Traders database, demonstrating SQL development from foundational queries to advanced, reusable analytical components.

## Environment & Tools
- **Database Engine:** Microsoft SQL Server
- **Client/Interface:** SQL Server Management Studio (SSMS)

## Repository Structure
- `01-foundation/`: Basic SELECT statements, filtering, and sorting.
- `02-Joins/`: Multi-table relations (INNER, LEFT, RIGHT).
- `03-Aggregation/`: Grouping data and summary statistics.
- `04-SUBQUERIES & CTES/`: Complex logic and query optimization.
- `06-Reusable Building Blocks/`: Views, Stored Procedures, and modular design.
- `Project_Details/`: Documentation and database files.

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
