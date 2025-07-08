Create database lesson_2
use lesson_2


/*Basic-Level Tasks (10)*/


Create table Employees (EmpID INT, Name VARCHAR(50), Salary DECIMAL(10,2))
insert into Employees values
(1, 'Shaxriyorbek', 2000),
(2, 'Hamid', 1200), (3, 'Nodirbek', 2500);

select *from employees

update employees
set salary=7000
where EmpID=1



delete from Employees
where Empid=2

delete Removes specific rows from a table based on a WHERE condition. It can be rolled back (transaction-safe), Triggers are fired and 
Slower for large data

Truncate removes all rows from a table quickly. It cannot delete specific rows (no WHERE), it cannot be rolled back in some databases and it triggers usually not fired

Drop completely removes the table (or database) from the schema.it deletes the structure and all data.
it cannot be rolled back and Everything is gone — data and table definition


alter table employees
alter column Name varchar(100)

alter table Employees
Add Department varchar(50)

alter table employees
alter column Salary Float

select *from Employees

/*Advanced-Level Tasks (9)*/

Create table Departments (DepartmentID INT PRIMARY KEY, DepartmentName VARCHAR(50))

truncate table Employees


Insert into Departments values
(1, 'HR'),
(2, 'IT'),
(3, 'Budget')

alter table departments
add Department varchar(50)  

Update Employees 
set Department = 'Management'
where Salary >5000

Delete from Departments 
where DepartmentID=1 or DepartmentID=2 or DepartmentID=3

Alter table Employees
drop column Department

exec sp_rename 'Employees', 'StaffMembers '
Drop table Departments

Select *from StaffMembers 

-------------------------------------------------------------------------------
/*Advanced-Level Tasks (9)*/

create table Products 
(ProductID INt Primary Key, 
ProductName VARCHAR(50), 
Category VARCHAR(50), 
Price DECIMAL(10,2) CHECK (Price > 0), 
StockQuantity INT)

update Products 
set category='ProductCategory'

Insert into products values
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Chair', 'Furniture', 85.50),
(3, 'Notebook', 'Stationery', 3.25),
(4, 'Smartphone', 'Electronics', 899.99),
(5, 'Water Bottle', 'Kitchen', 12.00);

Select * into products_backup from products
exec sp_rename 'Products','Inventory'

alter table inventory
alter column price float

alter table inventory
add ProductCode int identity(1000,5)

select *from inventory
