create database Lesson_5_homework;
use Lesson_5_homework

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Price DECIMAL(10, 2),
    Category VARCHAR(50),
    StockQuantity INT
);

select *from Products

select ProductName as Name from Products
