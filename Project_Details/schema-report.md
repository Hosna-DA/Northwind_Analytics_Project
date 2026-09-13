# Northwind Database — Schema Report

This report documents every table in the Northwind database, its columns, 
and its primary/foreign key relationships.

---

### 1. Categories
**About:** Category of groceries.

| Column | Key |
|---|---|
| CategoryID | PK |
| CategoryName | |
| Description | |
| Picture | |

---

### 2. Customers
**About:** Companies which are our customers, and their contact person.

| Column | Key |
|---|---|
| CustomerID | PK |
| CompanyName | |
| ContactName | |
| ContactTitle | |
| Address | |
| City | |
| Region | |
| PostalCode | |
| Country | |
| Phone | |
| Fax | |

---

### 3. Employees
**About:** Company employees and their information.

| Column | Key |
|---|---|
| EmployeeID | PK |
| LastName | |
| FirstName | |
| Title | |
| TitleOfCourtesy | |
| BirthDate | |
| HireDate | |
| Address | |
| City | |
| Region | |
| PostalCode | |
| Country | |
| HomePhone | |
| Extension | |
| Photo | |

---

### 4. Suppliers
**About:** Supplier companies with their contact information.

| Column | Key |
|---|---|
| SupplierID | PK |
| CompanyName | |
| ContactName | |
| ContactTitle | |
| Address | |
| City | |
| Region | |
| PostalCode | |
| Country | |
| Phone | |
| Fax | |
| HomePage | |

---

### 5. Orders
**About:** Orders and how they should be transported.

| Column | Key |
|---|---|
| OrderID | PK |
| CustomerID | FK → Customers |
| EmployeeID | FK → Employees |
| OrderDate | |
| RequiredDate | |
| ShippedDate | |
| ShipVia | |
| Freight | |
| ShipName | |
| ShipAddress | |
| ShipCity | |
| ShipRegion | |
| ShipPostalCode | |
| ShipCountry | |

---

### 6. Products
**About:** Products and their order status.

| Column | Key |
|---|---|
| ProductID | PK |
| ProductName | |
| SupplierID | FK → Suppliers |
| CategoryID | FK → Categories |
| UnitPrice | |
| QuantityPerUnit | |
| UnitsInStock | |
| UnitsOnOrder | |
| ReorderLevel | |
| Discontinued | |

---

### 7. Order Details
**About:** Line items linking orders to products, with quantity and pricing.

| Column | Key |
|---|---|
| OrderID | PK, FK → Orders |
| ProductID | PK, FK → Products |
| UnitPrice | |
| Quantity | |
| Discount | |

---

### 8. EmployeeTerritories
**About:** Links employees to the sales territories they cover.

| Column | Key |
|---|---|
| EmployeeID | FK → Employees |
| TerritoryID | FK → Territories |

---

### 9. Region
**About:** High-level geographic regions.

| Column | Key |
|---|---|
| RegionID | PK |
| RegionDescription | |

---

### 10. Territories
**About:** Sales territories, each belonging to a region.

| Column | Key |
|---|---|
| TerritoryID | PK |
| TerritoryDescription | |
| RegionID | FK → Region |

---

### 11. Shippers
**About:** Shipping companies and their contact phone.

| Column | Key |
|---|---|
| ShipperID | PK |
| CompanyName | |
| Phone | |

---

### 12–13. CustomerCustomerDemo / CustomerDemographics
**About:** Reserved for customer demographic segmentation — both tables are 
empty in this dataset and not used in the analysis.