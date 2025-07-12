create database lesson_3
use lesson_3

-----------------------------------------homework3---------------------------
BULK INSERT is a Transact-SQL (T-SQL) command in SQL Server that 
allows you to quickly import large volumes of data from a text file directly into a SQL Server table.

File formats are such as a .csv, .txt, or .dat file.

create table Products (ProductID int primary key, ProductName varchar(50), Price Decimal (10,2))

Insert Into Products (ProductID, ProductName, Price) Values
(1, 'Cola', 10000),
(2, 'Pepsi', 12000),
(3, 'Fanta', 13000);

In SQL, NULL and NOT NULL are used to define whether a column can hold missing or unknown values.
The column can contain NULL values, which represent missing, unknown, or undefined data.
The column must always have a value; NULL values are not allowed.

alter table Products
add constraint UQ_ProductName unique (ProductName)

/*	1. To prevent duplicate entries in one or more columns.
	2. To enforce data integrity by making sure certain fields contain only distinct values.*/

	

	Alter table Products
	add CategoryID int;

	Create table Categories (CategoryID int primary key, CategoryName varchar(50) unique, 
	ProductID int foreign key references Categories(CategoryID)  )

	The IDENTITY column in SQL Server is used to automatically 
	generate unique numeric values for a column, typically used as a primary key.

	BULK INSERT [lesson_3].[dbo].[Products]
FROM 'C:\Users\Pavilion\Documents\SQL Server Management Studio\Products.csv'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);


alter table Products
add constraint [FK_Products] int foreign key references Categories(CategoryID)


		Select *from Products
		select * from categories

		insert into Categories values
		(1, 'Ichimlik')




		Both PRIMARY KEY and UNIQUE constraints ensure uniqueness of data in a column or 
		set of columns — but they have important differences.

		alter table Products
		add constraint CHK_price check (price>0)

		alter table Products
		add stock int not null default 0;

		A FOREIGN KEY is a constraint in SQL Server that is used to create a relationship between two tables. 
		It ensures that the value in one column (or set of columns) matches a value in 
		another table`s primary key or unique key.



		create table customers (ID int primary key, Name varchar (50), age int, constraint CHK_age check (age>18 ))
		select *from customers

		Create table Custoemrs2 (ID int primary key Identity (100,10), Name varchar (50), age int)
		select *from customers

		CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10, 2),
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);

Both COALESCE and ISNULL are functions in SQL Server used to handle NULL values by 
replacing them with default values — but they have some differences.

CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    OrderDate DATE,
    CustomerID INT,
    CONSTRAINT FK_Orders_Customers
        FOREIGN KEY (CustomerID)
        REFERENCES Customers(CustomerID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



