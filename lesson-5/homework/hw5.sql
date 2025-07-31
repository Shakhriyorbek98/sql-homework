
/*1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.*/

select *from Products

SELECT ProductName AS Name
FROM Products;

/*2. Write a query that uses an alias to rename the Customers table as Client for easier reference.*/

SELECT *
FROM Customers AS Client;


/*3. Use UNION to combine results from two queries that select ProductName from 
Products and ProductName from Products_Discounted.*/



select productname from Products_Discounted
union
select productname from Products

/*4. Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.*/


select productid, productname, price, category, stockquantity from Products_Discounted
intersect
select productid, productname, price, category, stockquantity from Products

/* 5. Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT. */

select distinct firstname+' '+lastname as name, country from customers

/*6. Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, 
and 'Low' if Price <= 1000 from Products table.*/

	select*,
		case when price>1000 then 'High'
		else 'Low' end as conditional_column 
	from products;

	/* 7. Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise 
	(Products_Discounted table, StockQuantity column).*/

	select *,
		iif(stockquantity>100, 'Yes', 'No') as iif_condition
	from Products_Discounted

	/*8. Use UNION to combine results from two queries that select ProductName from Products 
	and ProductName from Products_Discounted tables.*/

select productname from Products_Discounted
	union
select productname from Products

/*9. Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.*/

select *from products
except
select *from Products_Discounted

/*10. Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, 
and 'Affordable' if less, from Products table. */

select *,
	iif(price>1000, 'Expensive', 'Affordable') as condition
from products

/*11. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.*/

select * from employees
where Age<25 or Salary>60000


/*12. Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5*/


UPDATE Employees
SET Salary = Salary * 1.10
WHERE Departmentname = 'HR' OR EmployeeID = 5;

/*13. Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 
'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)*/

select *,
	case when saleamount>500 then 'Top Tier'
	when saleamount>200 then 'Mid Tier'
	else 'Low Tier' end as Condition
from sales

/*14. Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Sales table.*/
	select CustomerID from Orders
		EXCEPT
	SELECT CustomerID FROM Sales;

/*15. Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. 
Use orders table. Result set should show customerid, quantity and discount percentage. 
The discount should be applied as follows: 1 item: 3% Between 1 and 3 items : 5% Otherwise: 7% */
SELECT 
    CustomerID,
    Quantity,
    CASE 
        WHEN Quantity = 1 THEN '3%'
        WHEN Quantity BETWEEN 2 AND 3 THEN '5%'
        ELSE '7%'
    END AS DiscountPercentage
FROM Orders;
