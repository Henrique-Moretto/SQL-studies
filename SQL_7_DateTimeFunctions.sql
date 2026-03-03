-- DATE AND TIME FUNCTIONS

use SalesDB;

select 
	OrderID, OrderDate,ShipDate, CreationTime
from Sales.Orders;

select 
	OrderID, CreationTime,
	'2026-01-02' as HardCoded,
	getdate() as Today
from Sales.Orders;

-- DAY(): return the day from a date
-- MONTH(): ''  ''  month  ''   ''
-- YEAR(): ''  ''  year  ''   ''

select 
	OrderID, CreationTime,
	year(CreationTime) as Year,
	month(CreationTime) as Month,
	day(CreationTime) as Day
from Sales.Orders;

-- DATEPART(): return a specific of a date as a number 

 select 
	OrderID, CreationTime,
	datepart(year, CreationTime) as Year_dp,
	datepart(month, CreationTime) as Month_dp,
	datepart(day, CreationTime) as Day_dp,
	datepart(hour, CreationTime) as Hour_dp,
	datepart(quarter, CreationTime) as Quarter_dp,
	datepart(week, CreationTime) as Week_dp,
	year(CreationTime) as Year,
	month(CreationTime) as Month,
	day(CreationTime) as Day
from Sales.Orders;

 -- DATENAME():  returns the name of a specific part of a date

 select 
	OrderID, CreationTime,
	datename(year, CreationTime) as Year_dn,
	datename(month, CreationTime) as Month_dn,
	year(CreationTime) as Year,
	month(CreationTime) as Month,
	day(CreationTime) as Day
from Sales.Orders;

-- DATETRUNC(): truncates the date to a specific part

select 
	OrderID, CreationTime,
	datetrunc(year, CreationTime) as Year_dt,
	datetrunc(month, CreationTime) as Month_dt,
	datetrunc(day, CreationTime) as Day_dt,
	datetrunc(hour, CreationTime) as Hour_dt,
	datetrunc(minute, CreationTime) as Minute_dt,
	datetrunc(second, CreationTime) as Second_dt,
	datetrunc(quarter, CreationTime) as Quarter_dt,
	datetrunc(week, CreationTime) as Week_dt,
	year(CreationTime) as Year,
	month(CreationTime) as Month,
	day(CreationTime) as Day
from Sales.Orders;

-- counting n# of orders

select CreationTime,
	count(*)
from Sales.Orders
group by CreationTime;

select datetrunc(month, Creationtime) as Creation,
	count(*) as n_orders
from Sales.Orders
group by datetrunc(month, Creationtime);

select
	datename(month, OrderDate),
	count(*) as n_orders
from Sales.Orders
group by datename(month, OrderDate);

select datetrunc(year, Creationtime) as Creation,
	count(*) as n_orders
from Sales.Orders
group by datetrunc(year, Creationtime);

select
	year(OrderDate),
	count(*) as n_orders
from Sales.Orders 
group by year(OrderDate)

-- EOMONTH(): returns the last day of a month

select
	OrderID,
	CreationTime,
	eomonth(CreationTime) as EndOfMonth,
	cast(datetrunc(month, Creationtime) as date)as BeginOfMonth
from Sales.Orders;

-- show all order that were placed during the month of February

select *
from Sales.Orders
where month(OrderDate) = 2;

-- FORMAT(): formats a date or time value

select
	OrderID,
	CreationTime,
	format(CreationTime, 'MM-dd-yyyy') as USA_format,
	format(CreationTime, 'dd-MM-yyyy') as Euro_foramt,
	format(CreationTime, 'dd') as dd,
	format(CreationTime, 'ddd') as ddd,
	format(CreationTime, 'dddd') as dddd,
	format(CreationTime, 'MM') as MM,
	format(CreationTime, 'MMM') as MMM,
	format(CreationTime, 'MMMM') as MMMM,
	format(CreationTime, 'yy') as yy,
	format(CreationTime, 'yyy') as yyy
from Sales.Orders;

-- show CreationTime using the format: Day Wed Jan Q1 2025 12:34:56 PM

select
	OrderID,
	CreationTime,
	'Day ' + format(CreationTime, 'ddd MMM') +
	' Q' + datename(quarter, CreationTime) 
	+ format(CreationTime, ' yyyy hh:mm:ss tt') as Custom_Format
from Sales.Orders;

select
	format(OrderDate, 'MMM yy') as OrderDate,
	count(*) as n_order
from Sales.Orders
group by format(OrderDate, 'MMM yy');

-- CONVERT(data_type, value, [,style]): converts a date or time value to a different data type

select
	convert(int, '123') as [String to Int convert],
	convert(date, '2025-08-20') as [String to Date convert],
	Creationtime,
	convert(date, Creationtime) as [DateTime to Date convert],
	convert(varchar, Creationtime, 32) as [USA Std. Style: 32],
	convert(varchar, Creationtime, 34) as [EURO Std. Style: 34]
from Sales.Orders;

-- CAST(value as data_type): converts a value to a specific datatype

select
	cast('123' as int) as [String to Int],
	cast(123 as varchar) as [Int to String],
	cast('2025-08-20' as date) as [String to Date],
	cast('2025-08-20' as datetime2) as [String to DateTime],
	CreationTime,
	cast(CreationTime as date) as [DateTime to Date]
from Sales.Orders;

-- GETEADD(part,interval, date): adds or subtracts a specific time interval to/from a date

select
	OrderID,
	OrderDate,
	dateadd(day, -10, OrderDate) as ten_days_beore,
	dateadd(month, 3, OrderDate) as three_months_later,
	dateadd(year, 2, OrderDate) as two_year_later
from Sales.Orders;

-- DATEDIFF(part, start_date, end_date): find the difference between two dates

-- calculate the age of employees

select * from Sales.Employees

select
	EmployeeID,
	BirthDate,
	datediff(year, BirthDate, getdate()) as Age
from Sales.Employees;

-- find the average shipping duration in days for each month

select OrderID, OrderDate, ShipDate, datediff(day, OrderDate, ShipDate) as duration
from Sales.Orders;

select 
	month(OrderDate) as OrderDate,
	avg(datediff(day, OrderDate, ShipDate)) as avg_duration
from Sales.Orders
group by month(OrderDate);

-- find the number of days between each order and previous order

select
	OrderID,
	OrderDate as current_order_date,
	lag(OrderDate) over (order by OrderDate) as previous_order_date,
	datediff(day, lag(OrderDate) over (order by OrderDate), OrderDate) as n_days
from Sales.Orders

-- ISDATE(): chack if a value is a date ( 1-true, 0-false)

select
isdate('123') datacheck1
,isdate('2025-08-20') datacheck2
,isdate('20-08-2025') datacheck3
,isdate('2025') datacheck4
,isdate('08') datacheck5

select
	--cast(OrderDate as Date) as OrderDate
	isdate(OrderDate) as datacheck,
	case when isdate(OrderDate) = 1 then cast(OrderDate as date)
	else '9999-01-01' 
	end NewOrderDate
from
(
	select '2025-08-20' as OrderDate union
	select '2025-08-21' union
	select '2025-08-22' union
	select '2025-08'
) as t
--where isdate(Order Date) = 0 --check wrong data