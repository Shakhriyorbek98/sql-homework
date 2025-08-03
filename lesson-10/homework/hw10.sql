----------------------------lesson_10_homeworks-----------------------------

/*1.Using the Employees and Departments tables, write a query to return the names and salaries of 
employees whose salary is greater than 50000, along with their department names.  */

select e.departmentid, Name, salary, DepartmentName  from employees e join departments d on e.DepartmentID=d.DepartmentID
where salary >50000

/*2. Using the Customers and Orders tables, write a query to display customer names and 
order dates for orders placed in the year 2023.*/

select firstname+' '+lastname name, orderdate from customers c join orders o on c.customerid=o.customerid
where year(orderdate)=2023


/*3. Using the Employees and Departments tables, write a query to show all employees along with their department names. 
Include employees who do not belong to any department.*/

select name, DepartmentName from employees e join departments d on e.departmentid=d.departmentid

/*4. Using the Products and Suppliers tables, write a query to list all suppliers and the products they supply. 
Show suppliers even if they don’t supply any product.*/

select suppliername, productname from products p join suppliers s on p.SupplierID=s.SupplierID

/*5. Using the Orders and Payments tables, write a query to return all orders and their corresponding payments. 
Include orders without payments and payments not linked to any order.*/

select  o.OrderID,
    o.CustomerID,
    o.OrderDate,
    p.PaymentID,
    p.PaymentDate,
    p.Amount from orders o join payments p on o.orderid=p.orderid


/*6. Using the Employees table, write a query to show each employee's name along with the name of their manager.*/

	select em1.name, em2.name from employees em1 left join employees em2 on em1.managerid=em2.employeeid
	
/*7. Using the Students, Courses, and Enrollments tables, 
write a query to list the names of students who are enrolled in the course named 'Math 101'.*/







/*8. Using the Customers and Orders tables, write a query to find customers who have placed an order with more than 3 items. 
Return their name and the quantity they ordered.*/
	

	select firstname, lastname, quantity from customers c left join orders o on c.customerid=o.customerid
	where quantity >3

	
/*9. Using the Employees and Departments tables, write a query to list employees working in the 'Human Resources' department.*/

select name, departmentname from employees e left join departments d on e.departmentid=d.departmentid
where d.departmentname='human resources'


/*10. Using the Employees and Departments tables, write a query to return department names that have more than 5 employees.*/

	select d.departmentname, count(e.employeeid) from employees e  join departments d on e.departmentid=d.departmentid 
	group by d.departmentname having count (e.employeeid)>5 

/*11. Using the Products and Sales tables, write a query to find products that have never been sold.*/

	select productname, s.productid from products p left join sales s on p.productid=s.productid
	where saleid is null

/*12. Using the Customers and Orders tables, write a query to return customer names who have placed at least one order.*/

select firstname, lastname, quantity from customers c left join orders o on c.customerid=o.customerid
where quantity>=1

/*13. Using the Employees and Departments tables, 
write a query to show only those records where both employee and department exist (no NULLs).*/

	select name, departmentname from employees e left join departments d on e.departmentid=d.departmentid
	where departmentname is not null

/*14. Using the Employees table, write a query to find pairs of employees who report to the same manager.*/

	select e1.name as employee1, e2.name as employee2, e1.managerid, e3.name as managername from employees e1 join employees e2 on e1.managerid=e2.managerid join employees e3 on e1.managerid=e3.managerid
	where e1.employeeid < e2.employeeid

/*15. Using the Orders and Customers tables, write a query to list all orders placed in 2022 along with the customer name. */

	select orderid, orderdate, firstname, lastname from orders o left join customers c on o.customerid=c.customerid
	where year(orderdate)=2022
	
/*16. Using the Employees and Departments tables, 
write a query to return employees from the 'Sales' department whose salary is above 60000.*/

select name as employeename, salary,  from employees e join departments d on e.departmentid=d.departmentid
where d.departmentname = 'sales' and e.salary > 60000

/*17. Using the Orders and Payments tables, 
write a query to return only those orders that have a corresponding payment. */

	select p.orderid, orderdate, paymentdate, amount from orders o inner join payments p on o.orderid=p.orderid


/*18. Using the Products and Orders tables, write a query to find products that were never ordered. */

select p.productid, productname, orderid from products p left join orders o on p.productid=o.productid
where orderid is null

/*19. Using the Employees table, write a query to find employees whose salary is greater than 
the average salary in their own departments.*/



select name, salary from employees e1 
where e1.salary> (select avg(e2.salary) from employees e2 where e1.departmentid=e2.departmentid);

/* 20. Using the Orders and Payments tables, 
write a query to list all orders placed before 2020 that have no corresponding payment.*/ 
	
	select o.orderid, orderdate from orders o left join payments p on o.orderid=p.orderid
	where paymentid is null and year(orderdate)< 2020

/* 21. Using the Products and Categories tables, 
write a query to return products that do not have a matching category. */

select productid, productname from products p left join categories c on p.category=c.categoryname
where category is null

/*22. Using the Employees table, 
write a query to find employees who report to the same manager and earn more than 60000.*/


	SELECT 
    e1.EmployeeID AS Employee1_ID,
    e1.Name AS Employee1_Name,
    e2.EmployeeID AS Employee2_ID,
    e2.Name AS Employee2_Name,
    e1.ManagerID,
    m.Name AS ManagerName
FROM 
    Employees e1
JOIN 
    Employees e2 ON e1.ManagerID = e2.ManagerID
                 AND e1.EmployeeID < e2.EmployeeID
JOIN 
    Employees m ON e1.ManagerID = m.EmployeeID
WHERE 
    e1.Salary > 60000 AND e2.Salary > 60000;

/*23. Using the Employees and Departments tables, 
write a query to return employees who work in departments which name starts with the letter 'M'.*/

	select name, departmentname from employees e left join departments d on e.departmentid=d.departmentid
	where departmentname like 'M%'

/*24. Using the Products and Sales tables, 
write a query to list sales where the amount is greater than 500, including product names. */

select saleid, productname, saleamount from products p left join sales s on p.productid=s.productid
where saleamount >500


/*25. Using the Students, Courses, and Enrollments tables, 
write a query to find students who have not enrolled in the course 'Math 101'. */



/*26. Using the Orders and Payments tables, write a query to return orders that are missing payment details.*/

select *from orders o left join payments p on o.orderid=p.orderid
where paymentid is null

/*27. Using the Products and Categories tables, 
write a query to list products that belong to either the 'Electronics' or 'Furniture' category.*/

	select *from products p left join categories c on p.category=c.categoryname
	where categoryname in ('electronics', 'furniture')
