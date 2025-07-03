1. Data:
Data is a collection of raw facts, figures, or statistics that can be processed to generate meaningful information. 
Example: numbers, text, dates.

2. Database:
A database is an organized collection of data that is stored and accessed electronically. 
It allows for efficient storage, retrieval, and management of data.

3. Relational Database:
A relational database is a type of database that stores data in tables (relations) with rows and columns. 
Each table has a unique primary key, and tables can be related to each other using foreign keys.

4. Table:
A table is a structure within a database that organizes data into rows and columns. 
Each row represents a record, and each column represents a field or attribute.

	Create database SchoolDB
		use SchoolDB

		Create table Students (StudentID INT PRIMARY KEY, Name VARCHAR(50), Age INT)
		insert into Students values 
		(1, 'Oromjonov', 27),
		(2, 'Ergashev', 30),
		(3, 'Sobirjonov', 31);

		select *from Students

		SQL			Server			Software	Stores and manages data (the actual database system)
		SSMS		Application		Tool to interact with SQL Server (GUI interface)
		SQL			Language		Command language to work with data in SQL Server


		DQL is selecting. select is usied to query data from a table
		DML is insert, update and delete. insert is adding new data into a table. update is modifying existing data. 
		delete is removing data from a table.

		DDl is create(creating tables, databases), alter(modify table structure), drop (delete database objects) and 
		truncate removing all rows from a table quickly.

		DCl is grant (give user access rights) and revoke (remove access rights)
		TCL is commit (Save changes permanently), Rollback (Undo changes if something goes wrong), 
		SAVEPOINT(Set a point in a transaction to roll back to) and BEGIN TRANSACTION (Marks the start of a transaction).
