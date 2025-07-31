/*1. Define the following terms: data, database, relational database, and table.*/ 
Data refers to raw facts, figures, or values that have not yet been processed or interpreted.

A database is an organized collection of data that is stored and accessed electronically. 
It allows users to store, manage, retrieve, and manipulate data efficiently.

A relational database is a type of database that stores data in tables with rows and columns. 
Relationships between data are established using keys (like primary and foreign keys). 
It follows the relational model introduced by E.F. Codd.

A table is a structured set of data in a relational database, organized into rows (records) and columns (fields). 
Each table usually represents one entity (like Customers, Products, or Orders).

/*2. List five key features of SQL Server.*/

1. Relational Database Management
2. Transact-SQL (T-SQL) Support
3. Security Features
4. High Availability and Disaster Recovery (HADR)
5. Integration Services and Tools


/*3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)*/

1. Windows Authentication

- Uses the Windows user account credentials to connect.
- Relies on the Windows security system (Active Directory) to manage access.
- More secure and manageable in enterprise environments.
- No need to store passwords in SQL Server.

2. 2. SQL Server Authentication
- Uses SQL Server-specific login credentials (username and password stored in SQL Server).
- Independent of Windows accounts.
- Useful when connecting from non-Windows systems or when mixed environment is needed.

/* 4. Create a new database in SSMS named SchoolDB.*/

create database SchoolDB
GO

/*5. Write and execute a query to create a table called Students with columns: 
StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).*/

create table Students (StudentID int primary key, Name varchar(50), Age int)

/*6. Describe the differences between SQL Server, SSMS, and SQL.*/

1. SQL Server
What it is: A Relational Database Management System (RDBMS) developed by Microsoft.
-Purpose: Stores, manages, and processes data.
-Key Features: Security, transaction support, indexing, high availability, and more.
-Example: You install SQL Server on a server or PC to host and manage databases like SchoolDB.

2. SSMS (SQL Server Management Studio)
What it is: A graphical user interface (GUI) tool for managing SQL Server.
-Purpose: Allows users to interact with SQL Server — write queries, create tables, manage backups, users, and more.
-Key Features: Query editor, object explorer, visual database tools.
-Example: You open SSMS to connect to SQL Server and run SQL commands.

3. SQL (Structured Query Language)
What it is: A language used to communicate with relational databases.
-Purpose: Used to create, read, update, and delete data (CRUD operations) and define database structures.
-Key Features: Universal standard supported by most databases (including SQL Server, MySQL, PostgreSQL).

/* 7. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples. */

1. DQL (Data Query Language)
Purpose: Retrieve data from the database.
Main Command:
SELECT – used to query data from tables.

2. DML (Data Manipulation Language)
Purpose: Modify data inside existing tables.
Main Commands:
INSERT – add new data
UPDATE – modify existing data
DELETE – remove data

3. DDL (Data Definition Language)
Purpose: Define or modify the structure of the database and its objects.
Main Commands:
CREATE – create tables, databases, etc.
ALTER – change table structure
DROP – delete table or database
TRUNCATE – remove all data from a table (faster than DELETE)

4. DCL (Data Control Language)
Purpose: Control access and permissions on database objects.
Main Commands:
GRANT – give permissions
REVOKE – take back permissions

5. TCL (Transaction Control Language)
Purpose: Manage transactions, i.e., group of SQL operations treated as a single unit.
Main Commands:
COMMIT – save changes
ROLLBACK – undo changes
SAVEPOINT – mark a point for partial rollback
BEGIN TRANSACTION – start a transaction

/* 8. Write a query to insert three records into the Students table. */

INSERT INTO Students (StudentID, Name, Age)
VALUES
    (1, 'Ali', 20, 'Computer Science'),
    (2, 'Zarina', 22, 'Mathematics'),
    (3, 'Jasur', 21, 'Physics');

/* 9. Restore AdventureWorksDW2022.bak file to your server. 
(write its steps to submit) You can find the database from this link :
https://github.com/Microsoft/sql-server-samples/releases/download/adventureworks/AdventureWorksDW2022.bak */

Step 1: Download the .bak File
Go to this official link:
🔗 Download AdventureWorksDW2022.bak

Step 2: Move the File to SQL Server Backup Folder (Optional but Recommended)
Move the .bak file to SQL Server’s default backup directory:

Step 3: Open SSMS and Connect to SQL Server
Open SQL Server Management Studio (SSMS)
Connect to your SQL Server instance

Step 4: Restore the Database via GUI
In Object Explorer, right-click on Databases → Restore Database...
Select Device, then click the ... button
Click Add, and browse to your .bak file location
Select AdventureWorksDW2022.bak and click OK
Ensure the Destination database is set to AdventureWorksDW2022
(Optional) In the Files tab, adjust the file paths if needed (e.g., to a valid data/log file directory)
Click OK to start the restore process

Step 5 (Alternative): Restore Using T-SQL Script
If you prefer using SQL:
RESTORE DATABASE AdventureWorksDW2022
FROM DISK = 'C:\Backups\AdventureWorksDW2022.bak'
WITH MOVE 'AdventureWorksDW2022_Data' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2022.mdf',
     MOVE 'AdventureWorksDW2022_Log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorksDW2022_log.ldf',
     REPLACE;
