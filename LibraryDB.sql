CREATE DATABASE LIBRARY;
USE LIBRARY;

--ADMIN--
CREATE LOGIN admin WITH PASSWORD = 'admin';
CREATE USER library_admin FOR LOGIN admin;

--GRANTS TO ADMIN--
GRANT ALTER ON Schema :: DBO TO library_admin;
GRANT REFERENCES TO library_admin;
GRANT CONTROL SERVER TO admin;
GRANT CREATE TABLE TO library_admin;
GRANT CREATE PROCEDURE TO library_admin;
GRANT CREATE FUNCTION TO library_admin;
GRANT CREATE VIEW TO library_admin;
GRANT EXECUTE ON GetBooks TO library_admin;
GRANT EXECUTE ON GetAuthors TO library_admin;
GRANT EXECUTE ON GetGenres TO library_admin;
GRANT EXECUTE ON GetStudents TO library_admin;
GRANT EXECUTE ON GetBookById TO library_admin;
GRANT EXECUTE ON GetBookByName TO library_admin;
GRANT EXECUTE ON GetBooksByAuthor TO library_admin;
GRANT EXECUTE ON GetBooksByGenre TO library_admin;
GRANT EXECUTE ON GetOrders TO library_admin;
GRANT EXECUTE ON GetReturns TO library_admin;
GRANT EXECUTE ON AddBook TO library_admin;
GRANT EXECUTE ON AddAuthor TO library_admin;
GRANT EXECUTE ON AddGenre TO library_admin;
GRANT EXECUTE ON AddStudent TO library_admin;
GRANT EXECUTE ON UpdateBook TO library_admin;
GRANT EXECUTE ON UpdateStudent TO library_admin;
GRANT EXECUTE ON DeleteBook TO library_admin;
GRANT EXECUTE ON DeleteAuthor TO library_admin;
GRANT EXECUTE ON DeleteGenre TO library_admin;
GRANT EXECUTE ON DeleteStudent TO library_admin;
GRANT EXECUTE ON RegisterStudent TO library_admin;
GRANT EXECUTE ON BlockStudent TO library_admin;
GRANT EXECUTE ON CountBooks TO library_admin;
GRANT EXECUTE ON GetBooksHistory TO library_admin;
GRANT EXECUTE ON GetAuthorsHistory TO library_admin;
GRANT EXECUTE ON GetGenresHistory TO library_admin;
GRANT EXECUTE ON GetStudentsHistory TO library_admin;
GRANT EXECUTE ON GetOrdersHistory TO library_admin;
GRANT EXECUTE ON ImportStudents TO library_admin;
GRANT EXECUTE ON ExportStudents TO library_admin;

EXEC sp_configure 'show advanced options', 1;
EXEC sp_configure 'xp_cmdshell', 1;
RECONFIGURE;

--CLIENT--
CREATE LOGIN client WITH PASSWORD = 'client';
CREATE USER library_client FOR LOGIN client; 

--GRANTS TO CLIENT--
GRANT EXECUTE ON GetBooksByAuthor TO library_client;
GRANT EXECUTE ON GetBooksByGenre TO library_client;
GRANT EXECUTE ON GetBookByName TO library_client;
GRANT EXECUTE ON GetOrdersByStudent TO library_client;
GRANT EXECUTE ON OrderBook TO library_client;
GRANT EXECUTE ON ReturnBook TO library_client;

