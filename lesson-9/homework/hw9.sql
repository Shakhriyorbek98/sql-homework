--1. Using Products, Suppliers table List all combinations of product names and supplier names.

select ProductName, SupplierName from products p join suppliers s on p.SupplierID=s.SupplierID

--2. Using Departments, Employees table Get all combinations of departments and employees. 

select d.DepartmentID, departmentname, EmployeeID, name from departments d join employees e on d.DepartmentID=e.DepartmentID

/*3. Using Products, Suppliers table List only the combinations where the supplier actually supplies the product. 
Return supplier name and product name*/

select SupplierName, ProductName  from products p join suppliers s on p.SupplierID=s.SupplierID

/*4. Using Orders, Customers table List customer names and their orders ID.*/

select firstname+' ' +lastname as customer_name, orderid from orders o join Customers c on o.CustomerID=c.CustomerID

/*5. Using Courses, Students table Get all combinations of students and courses.*/

select studentid, CourseID from students s join courses c on s.studentid=c.courseid

/*6. Using Products, Orders table Get product names and orders where product IDs match.*/

select p.productid, productname, OrderID from products p join orders o on p.ProductID=o.ProductID


/*7. Using Departments, Employees table List employees whose DepartmentID matches the department.*/

select Name, DepartmentName from departments d join employees e on d.DepartmentID=e.DepartmentID

/*8. Using Students, Enrollments table List student names and their enrolled course IDs.*/

select s.studentid, e.CourseID from students s join enrollments e on s.StudentID=e.StudentID

/* 9. Using Payments, Orders table List all orders that have matching payments. */
	
	select o.orderid, paymentid, paymentdate,amount, PaymentMethod, customerid, productid, orderdate, Quantity, totalamount 
	from payments p join orders o on p.orderid=o.orderid

/*10. Using Orders, Products table Show orders where product price is more than 100.*/

	select *from products p join orders o on p.productid=o.ProductID
	where price>100

/*11. Using Employees, Departments table List employee names and department names where department IDs are not equal. 
It means: Show all mismatched employee-department combinations.*/

select *from employees e join departments d on e.DepartmentID=d.DepartmentID
where ManagerID is null

/*12. Using Orders, Products table Show orders where ordered quantity is greater than stock quantity.*/

select *from orders o join products p on o.ProductID=p.ProductID
where quantity*totalamount>StockQuantity

/*13. Using Customers, Sales table List customer names and product IDs where sale amount is 500 or more.*/

	select firstname, lastname, ProductID from customers c join sales s on c.customerid=s.customerid
	where saleamount>=500

/*14. Using Courses, Enrollments, Students table List student names and course names they’re enrolled in.*/
SELECT 
    s.Name AS StudentName,
    c.CourseName AS CourseName
FROM 
    Enrollments e
JOIN 
    Students s ON e.StudentID = s.StudentID
JOIN 
    Courses c ON e.CourseID = c.CourseID
ORDER BY 
    s.Name, c.CourseName;


/*15. Using Products, Suppliers table List product and supplier names where supplier name contains “Tech”.*/

	select *from products p join Suppliers s on p.supplierid=s.SupplierID
	where SupplierName like '%tech%'

/*16. Using Orders, Payments table Show orders where payment amount is less than total amount.*/
select *from orders o join payments p on o.orderid=p.OrderID
where totalamount>amount

/*17. Using Employees and Departments tables, get the Department Name for each employee.*/

select name, departmentname from employees e join departments d on e.DepartmentID=d.DepartmentID

/*18. Using Products, Categories table Show products where category is either 'Electronics' or 'Furniture'.*/
	
	select *from products p join categories c on p.category=c.CategoryID
	where CategoryName in ('electronics', 'furniture')

/*19. Using Sales, Customers table Show all sales from customers who are from 'USA'. */
	
	select *from sales s join customers c on s.CustomerID=c.CustomerID
	where country='usa'

/*20. Using Orders, Customers table List orders made by customers from 'Germany' and order total > 100.*/

select *from orders o join customers c on o.customerid=c.customerid
where country = 'germany' and TotalAmount>100


/*21.Using Employees table List all pairs of employees from different departments.*/
	SELECT 
		e1.EmployeeID AS EmployeeID1,
		e1.Name AS EmployeeName1,
		e1.DepartmentID AS Department1,
		e2.EmployeeID AS EmployeeID2,
		e2.Name AS EmployeeName2,
		e2.DepartmentID AS Department2
	FROM 
		Employees e1
	JOIN 
		Employees e2 ON e1.EmployeeID < e2.EmployeeID
	WHERE 
		e1.DepartmentID <> e2.DepartmentID
	ORDER BY 
		e1.EmployeeID, e2.EmployeeID;

/*22. Using Payments, Orders, Products table List payment details where the paid 
amount is not equal to (Quantity × Product Price).*/

select *from payments p join orders o on p.orderid=o.orderid join products pr on o.productid=pr.productid
where totalamount <> quantity*price

/*23. Using Students, Enrollments, Courses table Find students who are not enrolled in any course.*/
SELECT s.StudentID, s.Name
FROM Students s
LEFT JOIN Enrollments e ON s.StudentID = e.StudentID
WHERE e.StudentID IS NULL;

/*24. Using Employees table List employees who are managers of someone, 
but their salary is less than or equal to the person they manage.*/

select e.name, e.salary, em.name, em.salary from employees e join employees em on e.employeeid=em.managerid
where e.salary<=em.salary;


/*25. Using Orders, Payments, Customers table List customers who have made an order, but no payment has been recorded for it. */
select * from payments p join orders o on p.orderid=o.orderid join customers c on o.customerid=c.customerid 
where paymentid is null
