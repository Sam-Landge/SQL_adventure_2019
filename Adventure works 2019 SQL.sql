
--AdventureWorks2019
SELECT *
FROM Person.Person

-- Make a column of First Name,Middle Name, Last Name, Full Name 
SELECT FirstName,MiddleName,LastName,FirstName+' '+MiddleName+' '+LastName As FullName
FROM Person.Person

-- Table where middle name is null
SELECT FirstName,MiddleName,LastName
FROM Person.Person
WHERE MiddleName is NULL

SELECT FirstName,MiddleName,LastName
FROM Person.Person
WHERE MiddleName is not NULL

-- Select where the marital status is S and gender is F
SELECT *
FROM HumanResources.Employee
WHERE MaritalStatus='S' AND Gender='F'

--- Where clause using IN to get the data of more then one columns
SELECT *
FROM HumanResources.Employee
WHERE JobTitle IN ('Research and Development Engineer','Stocker','Accounts Receivable Specialist')

---Using between operation to get the data from id between 15 and 20
SELECT *
FROM HumanResources.Employee
WHERE BusinessEntityID BETWEEN 15 AND 20

--- Select name which start with Ala
SELECT *
FROM Person.StateProvince
WHERE NAME LIKE 'Ala____'

---Order city in assending order
SELECT City,PostalCode
FROM Person.Address
ORDER BY City ,PostalCode 

--Order city in descending order

SELECT City,PostalCode
FROM Person.Address
ORDER BY City DESC

--Order by to sort the name in assending and last name is descending order
SELECT FirstName,MiddleName,LastName
FROM Person.Person
WHERE MiddleName IS NOT NULL
ORDER BY FirstName,LastName DESC

SELECT SalesOrderID,UnitPrice
FROM Sales.SalesOrderDetail

--Group by Sales order ID, sum of unit price as total unit priceas in a new column

SELECT SalesOrderID,SUM(UnitPrice) AS TotalUnitPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

-- Group by sales order id ,avg of unit price

SELECT SalesOrderID,AVG(UnitPrice) AS AverageUnitPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

SELECT SalesOrderID,COUNT(UnitPrice) AS CountUnitPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

SELECT SalesOrderID,MAX(UnitPrice) AS MAXPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

SELECT SalesOrderID,MIN(UnitPrice) AS MINPrice
FROM Sales.SalesOrderDetail
GROUP BY SalesOrderID

-- concate ignore the null value and write the full name
SELECT FirstName,MiddleName,LastName,
CONCAT(FirstName,' ',MiddleName,' ',LastName)As FullName
FROM Person.Person

--Count length of string
SELECT FirstName, LEN(FirstName) As LenghtOfString
FROM Person.Person

--First three character of first name starting from left
SELECT FirstName, LEFT(FirstName,3) As FirstThreeCharacter
FROM Person.Person

SELECT FirstName, RIGHT(FirstName,3) As FirstThreeCharacter
FROM Person.Person

--First name third and forth character
SELECT FirstName, SUBSTRING(FirstName,3,4) As ThirdAndForCharacter
FROM Person.Person

--Handling date
SELECT SalesOrderID,OrderDate
FROM Sales.SalesOrderHeader

-- Extract day from orer date
SELECT SalesOrderID,OrderDate,DAY(OrderDate) AS Day
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,OrderDate,MONTH(OrderDate) AS MONTh
FROM Sales.SalesOrderHeader

SELECT SalesOrderID,OrderDate,Year(OrderDate) AS year
FROM Sales.SalesOrderHeader

-- Display Current time
SELECT CURRENT_TIMESTAMP;

--Having clause is used for aggregate function,Don’t use where

SELECT*
FROM Sales.SalesOrderDetail

--Always follow this order

SELECT SalesOrderID, SUM(UnitPrice) AS TotalunitPrice
FROM Sales.SalesOrderDetail
WHERE SalesOrderID>5000
GROUP BY SalesOrderID
HAVING SUM(UnitPrice)>=7000
ORDER BY SalesOrderID DESC

--Creating Subquary

SELECT PurchaseOrderID,EmployeeID
FROM Purchasing.PurchaseOrderHeader
WHERE PurchaseOrderID = 3
(SELECT PurchaseOrderID
FROM Purchasing.PurchaseOrderDetail
WHERE PurchaseOrderID =3)

--Union remove the duplicate
--If you have to join tables use union
SELECT BusinessEntityID
FROM HumanResources.Employee
UNION 
SELECT BusinessEntityID
FROM Person.Person
UNION 
SELECT CustomerID
FROM Sales.Customer

--Union all does not remove duplicate

SELECT BusinessEntityID
FROM HumanResources.Employee
UNION ALL
SELECT BusinessEntityID
FROM Person.Person
UNION ALL
SELECT CustomerID
FROM Sales.Customer

--If you have to join columns use Join

-- Inner Join
SELECT pod.PurchaseOrderID,pod.PurchaseOrderDetailID,poh.OrderDate
FROM Purchasing.PurchaseOrderDetail pod
INNER JOIN
Purchasing.PurchaseOrderHeader poh
ON 
pod.PurchaseOrderID=poh.PurchaseOrderID

-- Left join give all the record of person table and that record is not present in business entity addres it will give null value

SELECT p.BusinessEntityID ,p.FirstName, p.LastName,bea.BusinessEntityID,bea.AddressID
FROM Person.Person p
LEFT JOIN
Person.BusinessEntityAddress bea
ON
p.BusinessEntityID = bea.BusinessEntityID

--Right join display all record of right table which id bea and not matching record as null
--Right join is same as right outer join
SELECT p.BusinessEntityID ,p.FirstName, p.LastName,bea.BusinessEntityID,bea.AddressID
FROM Person.Person p
RIGHT JOIN
Person.BusinessEntityAddress bea
ON
p.BusinessEntityID = bea.BusinessEntityID


-- Full Join join all weather matching or not
SELECT p.BusinessEntityID ,p.FirstName, p.LastName,bea.BusinessEntityID,bea.AddressID
FROM Person.Person p
FULL JOIN
Person.BusinessEntityAddress bea
ON
p.BusinessEntityID = bea.BusinessEntityID

-- Create database
CREATE DATABASE Covid119

--Create table
CREATE TABLE CovidStats
(CovidId INT IDENTITY(1,3),
CovidDate datetime,
CovidConferCases INT,
DaityDaith smallint,
country varchar(25),
covidflag bit,
totalloss money)

--Create table
CREATE TABLE ItemHeader
(
ItemId INT PRIMARY KEY ,
ItemName VARCHAR(50) UNIQUE ,
ItemOrderDate datetime NOT NULL,
ItemShipDate datetime NOT NULL,
ItemAmount money)

CREATE TABLE ItemDetail
(
ItemId INT,
ItemDetailID INT,
ItemDueDate datetime NOT NULL,
ItemOrderQuantity SMALLINT NOT NULL,
ItemReciveQuantity SMALLINT NOT NULL,
ItemShipDate datetime,
ItemAmount Money,
CONSTRAINT ItemDetailPK PRIMARY KEY (ItemId,ItemDetailID),
CONSTRAINT ItemDetailFK FOREIGN KEY (ItemId) REFERENCES ItemHeader(ItemId)
)

--Insert values
INSERT INTO dbo.CovidStats VALUES ('4/25/2020',1000,10,'USA',1,1000000)

--To Check
SELECT*
FROM CovidStats

--Insert this 2 data
INSERT INTO dbo.CovidStats (CovidDate,country) VALUES ('4/25/2020','TUVALY')

-- Showing null values because we didn't passes any values
SELECT*
FROM CovidStats

-- Added more records

INSERT INTO dbo.CovidStats (CovidDate,CovidConferCases,DaityDaith,country,covidflag,totalloss)
VALUES
('4/25/2020',800,6,'Brazil',1,500000),
('4/25/2020',750,6,'Rusia',1,550000),
('4/25/2020',0,0,'Palau',0,5000)

--To Check
SELECT*
FROM CovidStats

--Null values is covidid 4 row,we have to update it
UPDATE dbo.CovidStats SET covidflag=0,totalloss=100
WHERE CovidId=4

--To check
SELECT*
FROM CovidStats

--ALTER TABLE
ALTER TABLE CovidStats
ADD Continent char(12)

SELECT*
FROM CovidStats


--We again want to alter table
ALTER TABLE CovidStats
ALTER COLUMN Continent varchar(15)

SELECT*
FROM CovidStats

--Drop Column

ALTER TABLE CovidStats
DROP COLUMN Continent 

SELECT*
FROM CovidStats

--Delete row
DELETE FROM  CovidStats
WHERE country='Brazil' AND covidflag=1

--To check
SELECT*
FROM CovidStats

--Delete top 2 rows

DELETE TOP(2) 
FROM CovidStats

SELECT*
FROM CovidStats

--If want to drop the table DROP TABLE CovidStats