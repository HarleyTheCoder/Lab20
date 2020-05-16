--I'm putting the questions with them for my notes

-- #1 Select all the records from the "Customers" table.
SELECT * FROM customers;

-- #2 Get distinct countries from the Customers table. In other words, each country
--should only appear once in the results. (You’ll probably have to search online for
--this one.)

SELECT DISTINCT Country FROM customers;

-- #3 Get all the records from the table Customers where the Customer’s ID starts with
--“BL”.

SELECT * FROM customers WHERE CustomerID LIKE 'BL%';

-- #4 Get the first 100 records of the orders table.

SELECT * FROM orders WHERE OrderID <= 10348;

-- #5 Get all customers that live in the postal codes 1010, 3012, 12209, and 05023.

SELECT * FROM customers WHERE (PostalCode = 1010) OR (PostalCode = 3012)
OR (PostalCode = 12209) OR (PostalCode = 05023);

-- #6 Get all orders where the ShipRegion is not equal to NULL.

SELECT * FROM orders WHERE  ShipRegion IS NOT NULL;

-- #7 Get all customers ordered by the country, then by the city.

SELECT * FROM customers ORDER BY Country ASC, City ASC;

-- #8 Add a new customer to the customers table. You can use whatever values

INSERT INTO customers (CustomerID, CompanyName, ContactName,
 ContactTitle, Address, City, PostalCode, Country,
 Phone, Fax, Image, ImageThumbnail) VALUES ('BEAUE', 'Beauty Essentials',
 'Janet Arnold', 'Sales Agent', '143 E Main St', 'Bellevue', '49021', 'USA', '(902)555-4329',
 '(902)555-4385', 'company-image.jpg', 'company-thumbnail-image.jpg');
 
-- #9 Update all ShipRegion to the value ‘EuroZone’ in the Orders table, where the
--ShipCountry is equal to France. (Note: this requires safe updates to be turned off.
--Search online for more info.)
 
UPDATE orders SET ShipRegion='EuroZone' WHERE ShipCountry = 'France';
 
-- #10 Delete all orders from `order details` that have quantity of 1.
--( had to edit the properties so the name didn't have a space)
 
DELETE FROM orderdetails WHERE Quantity = 1; 
  
-- #11 Calculate the average, max, and min of the quantity at the `order details` table.

SELECT AVG(Quantity), MIN(Quantity), MAX(Quantity) FROM orderdetails;

-- #12  Calculate the average, max, and min of the quantity at the `order details` table,
--grouped by the orderid. This will show the average, max, and min for each order.

SELECT AVG(Quantity), MIN(Quantity), MAX(Quantity) FROM orderdetails GROUP BY OrderID;

-- #13  Find the CustomerID that placed order 10290 (orders table)

SELECT DISTINCT CustomerID FROM orders WHERE OrderID = '10290'; 

-- $14  Do an inner join, left join, right join on orders and customers tables. (These are
--three separate queries, one for each type of join.)

SELECT * FROM orders INNER JOIN customers ON orders.CustomerID = customers.CustomerID;
SELECT * FROM orders RIGHT JOIN customers ON orders.ShipCountry = customers.Country;
SELECT * FROM orders LEFT JOIN customers ON orders.ShipPostalCode = customers.PostalCode;

-- #15 Use a join to get the ship city and ship country of all the orders which are associated
--with an employee who is in London.

--I included the order # and employee ID for readability

SELECT DISTINCT employees.EmployeeID, orders.OrderID, orders.ShipCity, orders.ShipCountry 
FROM orders INNER JOIN employees WHERE orders.EmployeeID = employees.EmployeeID 
AND employees.City = 'London' ORDER BY orders.OrderID ASC;

-- #16  Use a join to get the ship name of all orders that include a discontinued product.
--(See orders, order details, and products. 1 means discontinued.)

SELECT DISTINCT orders.ShipName FROM orders LEFT JOIN orderdetails ON orders.OrderID =
orderdetails.OrderID LEFT JOIN products ON orderdetails.ProductID = products.ProductID 
WHERE products.Discontinued = '1' ORDER BY orders.ShipName ASC;

-- #17 Get employees’ firstname for all employees who report to no one.
-- (The Big Boss)
SELECT FirstName FROM employees WHERE ReportsTo IS NULL;

-- #18 Get employees’ firstname for all employees who report to Andrew.
-- (Technically, EVERYBODY reports to Andrew by extension)

-- (I'll pretend I don't know Andrew's ID.)

SELECT @bossNum := EmployeeID FROM employees WHERE FirstName = 'Andrew';
SELECT FirstName FROM employees WHERE ReportsTo = @bossNum;

