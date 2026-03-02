-- retrieve all data from customers and orders in two different results

use MyDatabase;

select * from customers;
select * from orders;

-- JOIN OPERATORS --

-- CLASSICAL JOINS

-- get all customers along with their orders, but only for customers who have placed an order

select 
	c.id, c.first_name, o.order_id, o.sales
from customers as c
inner join orders as o
on id = customer_id;

-- get all customers along with their orders, including those without orders

select c.id, c.first_name, o.order_id, o.sales
from customers as c
left join orders as o
on id = customer_id;

select c.id, c.first_name, o.order_id, o.sales
from orders as o
right join customers as c
on id = customer_id;

--get all customers along with yheir orders, including orders without matching customers

select c.id, c.first_name, o.order_id, o.sales
from customers as c
right join orders as o
on id = customer_id;

select c.id, c.first_name, o.order_id, o.sales
from orders as o
left join customers as c
on id = customer_id;
	
-- get all customers and all orders even if there's no match

select c.id, c.first_name, o.order_id, o.sales
from customers as c
full join orders as o
on id = customer_id;

-- ANTI JOINS

-- get all customers who haven't place any order

select * 
from customers as c
left join orders as o
on c.id = o.customer_id
where o.customer_id is null;

select * from orders as o
right join customers as c
on o.customer_id = c.id
where order_id is null;

-- get all orders without matching customers

select *
from customers as c
right join orders as o
on c.id = o.customer_id
where c.id is null;

select *
from orders as o
left join customers as c
on o.customer_id = c.id
where c.id is null;

-- find customers without orders and orders without customers

select * from customers as c
full join orders as o on c.id = o.customer_id
where c.id is null or o.customer_id is null;

-- get all customers along with their orders, but only for customers who have placed an order
-- without using inner join

select * from customers as c
left join orders as o on c.id = o.customer_id
where o.customer_id is not null;

-- CROSS JOIN

-- generate all possible combinations of customers and orders

select * from customers
cross join orders ;

-- MULTI-TABLE JOIN

/* Using SalesDB, retrieve a list of all orders, 
along with related customers, product and employee details, display:
order ID, customer's name, product name, sales, priece, sales person's name */

use SalesDB;

select * from Sales.Customers;

select * from Sales.Employees;

select * from Sales.Orders;

select * from Sales.OrdersArchive;

select * from Sales.Products;

select 
	o.OrderID, o.Sales, c.FirstName as CustomerFirstName, c.LastName as CustomerLastName,
	p.Product as Productname, o.Sales, p.Price,
	e.FirstName as EmployeeFirstName, e.LastName as EmployeeLastName
from Sales.Orders as o
left join Sales.Customers as c
on o.CustomerID = c.CustomerID
left join Sales.Products as p
on o.ProductID = p.ProductID
left join Sales.Employees as e
on SalesPersonID = EmployeeID


-- SET OPERATORS --

use SalesDB;

-- Combine the data from employees and customers into one table 

select FirstName, Lastname
from Sales.Customers
union
select FirstName, Lastname
from Sales.Employees;

-- Combine the data from employees and customers into one table, including duplicates 

select FirstName, Lastname
from Sales.Customers
union all
select FirstName, Lastname
from Sales.Employees;

-- retrieve all customers who are not employees

select FirstName, Lastname
from Sales.Customers
except
select FirstName, Lastname
from Sales.Employees;

-- retrive all customers who are also employees

select FirstName, Lastname
from Sales.Customers
intersect
select FirstName, Lastname
from Sales.Employees;

-- orders data are stored in separate tables (Orders and OrdersArchieve)
-- combine all orders data into one report without duplicates

select 
	'Orders' as SourceTable
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
,[CreationTime]
from Sales.Orders
union
select 
	'OrdersArchive' as SourceTable
	,[OrderID]
	,[ProductID]
	,[CustomerID]
	,[SalesPersonID]
	,[OrderDate]
	,[ShipDate]
	,[OrderStatus]
	,[ShipAddress]
	,[BillAddress]
	,[Quantity]
	,[Sales]
	,[CreationTime]
from Sales.OrdersArchive
order by OrderId asc;