USE LIBRARY;

--TABLES--
CREATE TABLE Books(
book_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
book_name NVARCHAR(50) NOT NULL,
book_publication_date NVARCHAR(30) NOT NULL,
book_price DECIMAL(5,2) NOT NULL,
book_quantity INT NOT NULL,
);

CREATE TABLE Authors(
author_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
author_first_name NVARCHAR(50) NOT NULL,
author_last_name NVARCHAR(50) NOT NULL,
);

CREATE TABLE Genres(
genre_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
genre_name NVARCHAR(50) NOT NULL,
);

CREATE TABLE Books_authors(
book_id INT NOT NULL,
book_author_id INT NOT NULL,
CONSTRAINT FK_Books_authors_Books FOREIGN KEY (book_id) REFERENCES Books (book_id),
CONSTRAINT FK_Books_authors_Authors FOREIGN KEY (book_author_id) REFERENCES Authors (author_id),
);

CREATE TABLE Books_genres(
book_id INT NOT NULL,
book_genre_id INT NOT NULL,
CONSTRAINT FK_Books_genres_Books FOREIGN KEY (book_id) REFERENCES Books (book_id),
CONSTRAINT FK_Books_genres_Genres FOREIGN KEY (book_genre_id) REFERENCES Genres (genre_id),
);

CREATE TABLE Students(
student_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
student_first_name NVARCHAR(50) NOT NULL,
student_last_name NVARCHAR(50) NOT NULL,
student_number INT NOT NULL UNIQUE,
student_faculty NVARCHAR(10) NOT NULL,
student_semester INT NOT NULL,
student_contact NVARCHAR(15) NOT NULL,
student_email NVARCHAR(50) NOT NULL,
student_registered_date DATETIME,
student_blocked_date DATETIME,
student_status NVARCHAR(10) CONSTRAINT CK_Student_Status CHECK (student_status IN ('Registered', 'Blocked')), 
);

CREATE TABLE Orders(
order_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
ordered_book_id INT NOT NULL,
student_id INT NOT NULL,
student_number INT NOT NULL,
ordered_book_name NVARCHAR(50) NOT NULL,
ordered_book_quantity INT,
order_date DATE
CONSTRAINT FK_Orders_Students FOREIGN KEY (student_id) REFERENCES Students (student_id),
CONSTRAINT FK_Orders_Books FOREIGN KEY (ordered_book_id) REFERENCES Books (book_id),
);

CREATE TABLE ReturnOrders(
return_id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
ordered_book_id INT NOT NULL,
student_id INT NOT NULL,
student_number INT NOT NULL,
ordered_book_name NVARCHAR(50) NOT NULL,
total_ordered_book_quantity INT,
returned_book_quantity INT,
return_date DATE,
CONSTRAINT FK_Returns_Students FOREIGN KEY (student_id) REFERENCES Students (student_id),
CONSTRAINT FK_Returns_Books FOREIGN KEY (ordered_book_id) REFERENCES Books (book_id),
);

CREATE TABLE BooksHistory 
(
    id INT IDENTITY PRIMARY KEY,
    book_id INT NOT NULL,
    operation NVARCHAR(200) NOT NULL,
    creation_date DATETIME NOT NULL DEFAULT GETDATE(),
);

CREATE TABLE AuthorsHistory 
(
    id INT IDENTITY PRIMARY KEY,
    author_id INT NOT NULL,
    operation NVARCHAR(200) NOT NULL,
    creation_date DATETIME NOT NULL DEFAULT GETDATE(),
);

CREATE TABLE GenresHistory 
(
    id INT IDENTITY PRIMARY KEY,
    genre_id INT NOT NULL,
    operation NVARCHAR(200) NOT NULL,
    creation_date DATETIME NOT NULL DEFAULT GETDATE(),
);

CREATE TABLE StudentsHistory 
(
    id INT IDENTITY PRIMARY KEY,
    student_id INT NOT NULL,
    operation NVARCHAR(200) NOT NULL,
    creation_date DATETIME NOT NULL DEFAULT GETDATE(),	
);

--VIEWS--
GO
CREATE VIEW BooksView
	AS SELECT * FROM Books;

GO
CREATE VIEW AuthorsView
	AS SELECT * FROM Authors;

GO
CREATE VIEW GenresView
	AS SELECT * FROM Genres;

GO
CREATE VIEW StudentsView
	AS SELECT * FROM Students;
		
GO
CREATE VIEW OrdersView
	AS SELECT * FROM Orders;

GO
CREATE VIEW ReturnsView
	AS SELECT * FROM ReturnOrders;	

--INDEXES--
CREATE INDEX FindBookByName 
	ON Books (book_name);
--DROP INDEX FindBookByName ON Books;

DBCC dropcleanbuffers;
checkpoint

--TRIGGERS--
GO
CREATE TRIGGER BooksInsert 
	ON Books
AFTER INSERT
AS
INSERT INTO BooksHistory (book_id, operation)
	SELECT book_id, 'Добавлена книга: ' + book_name 
		FROM INSERTED;

GO
CREATE TRIGGER BooksDelete
	ON Books
AFTER DELETE
AS
INSERT INTO BooksHistory (book_id, operation)
	SELECT book_id, 'Удалена книга: ' + book_name 
		FROM DELETED;
	 
GO
CREATE TRIGGER AuthorsInsert 
	ON Authors
AFTER INSERT
AS
INSERT INTO AuthorsHistory (author_id, operation)
	SELECT author_id, 'Добавлен автор: ' + author_first_name + ' ' + author_last_name
		FROM INSERTED;

GO
CREATE TRIGGER AuthorsDelete
	ON Authors
AFTER DELETE
AS
INSERT INTO AuthorsHistory (author_id, operation)
	SELECT author_id, 'Удалён автор: ' + author_first_name + ' ' + author_last_name
		FROM DELETED;
	 
GO
CREATE TRIGGER GenresInsert 
	ON Genres
AFTER INSERT
AS
INSERT INTO GenresHistory(genre_id, operation)
	SELECT genre_id, 'Добавлен жанр: ' + genre_name
		FROM INSERTED;

GO
CREATE TRIGGER GenresDelete
	ON Genres
AFTER DELETE
AS
INSERT INTO GenresHistory (genre_id, operation)
	SELECT genre_id, 'Удалён жанр: ' + genre_name
		FROM DELETED;

GO
CREATE TRIGGER StudentsInsert 
	ON Students
AFTER INSERT
AS
INSERT INTO StudentsHistory(student_id, operation)
	SELECT student_id, 'Добавлен студент: ' + student_first_name + ' ' + student_last_name
		FROM INSERTED;
		
GO
CREATE TRIGGER StudentsDelete
	ON Students
AFTER DELETE
AS
INSERT INTO StudentsHistory (student_id, operation)
	SELECT student_id, 'Удалён студент: ' + student_first_name + ' ' + student_last_name
		FROM DELETED;
	
--GET PROCEDURES--
GO
CREATE PROCEDURE GetBooks AS
BEGIN	
	SELECT * FROM BooksView
		ORDER BY book_id;
END;

GO
CREATE PROCEDURE GetAuthors AS
BEGIN	
	SELECT * FROM AuthorsView;
END;

GO
CREATE PROCEDURE GetGenres AS
BEGIN	
	SELECT * FROM GenresView;
END;

GO
CREATE PROCEDURE GetStudents AS
BEGIN	
	SELECT * FROM StudentsView;
END;

GO
CREATE PROCEDURE GetOrders AS
BEGIN	
	SELECT * FROM OrdersView;
END;

GO
CREATE PROCEDURE GetReturns AS
BEGIN	
	SELECT * FROM ReturnsView;
END;

GO
CREATE PROCEDURE GetBookById 
	@book_id INT
AS
BEGIN
	SELECT * FROM Books	
		WHERE book_id = @book_id;
END;

GO
CREATE PROCEDURE GetBookByName
	@book_name NVARCHAR(50)
AS
BEGIN
	SELECT * FROM Books	
		WHERE book_name = @book_name
			ORDER BY book_id;
			
END;

GO
CREATE PROCEDURE GetBooksByAuthor
	@book_author_last_name NVARCHAR(50)
AS
BEGIN	
	SELECT author_first_name, author_last_name, book_name, book_price, book_quantity, book_publication_date, genre_name
	   FROM Authors AS A
			INNER JOIN Books_authors AS B_a
				ON A.author_id = B_a.book_author_id
			INNER JOIN Books AS B
				ON B_a.book_id = B.book_id
			INNER JOIN Books_genres AS B_g
				ON B.book_id = B_g.book_id
			INNER JOIN Genres AS G
				ON B_g.book_genre_id = G.genre_id
					WHERE A.author_last_name = @book_author_last_name
						GROUP BY B.book_id, author_first_name, author_last_name, book_name, book_price, book_quantity, book_publication_date, genre_name
							ORDER BY B.book_id;
END;

GO
CREATE PROCEDURE GetBooksByGenre
	@book_genre NVARCHAR(50)
AS
BEGIN	
	SELECT genre_name, book_name, book_price, book_quantity, book_publication_date, author_first_name, author_last_name
	   FROM Genres AS G
			INNER JOIN Books_genres AS B_g
				ON G.genre_id = B_g.book_genre_id
			INNER JOIN Books AS B
				ON B_g.book_id = B.book_id
			INNER JOIN Books_authors AS B_a
				ON B.book_id = B_a.book_id
			INNER JOIN Authors AS A
				ON B_a.book_author_id = A.author_id
					WHERE G.genre_name = @book_genre
						GROUP BY B.book_id, genre_name, book_name, book_price, book_quantity, book_publication_date, author_first_name, author_last_name
							ORDER BY B.book_id;
END;

GO
CREATE PROCEDURE GetStudentByNumber
	@student_number INT
AS
BEGIN
	SELECT * FROM Students	
		WHERE student_number = @student_number;
END;

--ADD PROCEDURES--
GO
CREATE PROCEDURE AddBook  	
	@book_name NVARCHAR(50),	
	@book_publication_date NVARCHAR(30),	
	@book_price DECIMAL(5,2),
	@book_quantity INT,
	@book_author_first_name NVARCHAR(50),
	@book_author_last_name NVARCHAR(50),
	@book_genre NVARCHAR(50)
AS
BEGIN				
	IF(NOT @book_author_last_name = ANY (SELECT author_last_name FROM Authors))				
		BEGIN
			INSERT INTO Authors VALUES (@book_author_first_name, @book_author_last_name);								
		END;
	IF(NOT @book_genre = ANY (SELECT genre_name FROM Genres))				
		BEGIN
			INSERT INTO Genres VALUES (@book_genre);																			
		END;
	INSERT INTO Books VALUES (@book_name, @book_publication_date, @book_price, @book_quantity);	
	DECLARE @book_id INT;
	DECLARE @book_author_id INT;
	DECLARE @book_genre_id INT;
	SET @book_id = (SELECT book_id FROM Books 
						WHERE book_name = @book_name);
	SET @book_author_id = (SELECT author_id FROM Authors 
								WHERE author_first_name = @book_author_first_name AND author_last_name = @book_author_last_name);
	SET @book_genre_id = (SELECT genre_id FROM Genres 
								WHERE genre_name = @book_genre);								
	INSERT INTO Books_authors VALUES (@book_id, @book_author_id);
	INSERT INTO Books_genres VALUES (@book_id, @book_genre_id);	
	SELECT * FROM Books 
		WHERE book_id = @book_id;
END;

GO
CREATE PROCEDURE AddAuthor  	
	@book_author_first_name NVARCHAR(50),
	@book_author_last_name NVARCHAR(50)
AS
BEGIN
	INSERT INTO Authors VALUES (@book_author_first_name, @book_author_last_name);
	SELECT * FROM Authors 
		WHERE author_first_name = @book_author_first_name AND author_last_name = @book_author_last_name;
END;

GO
CREATE PROCEDURE AddGenre  	
	@book_genre NVARCHAR(50)
AS
BEGIN
	INSERT INTO Genres VALUES (@book_genre);
	SELECT * FROM Genres 
		WHERE genre_name = @book_genre;
END;

GO
CREATE PROCEDURE AddStudent  	
	@student_first_name NVARCHAR(50),	
	@student_last_name NVARCHAR(50),	
	@student_number INT,	
	@student_faculty NVARCHAR(10),
	@student_semester INT,
	@student_contact NVARCHAR(15),
	@student_email NVARCHAR(50),
	@student_registered_date DATETIME = NULL,
	@student_blocked_date DATETIME = NULL,
	@student_status NVARCHAR(10) = 'Blocked'
AS
BEGIN	
	INSERT INTO Students VALUES (@student_first_name, @student_last_name, @student_number, @student_faculty, @student_semester,
		@student_contact, @student_email, @student_registered_date, @student_blocked_date, @student_status);
	SELECT * FROM Students 
		WHERE student_number = @student_number;
END;

--UPDATE PROCEDURES--
GO
CREATE PROCEDURE UpdateBook
	@book_id INT,
	@book_name NVARCHAR(50),	
	@book_publication_date NVARCHAR(30),	
	@book_price DECIMAL(5,2),
	@book_quantity INT,
	@book_author_first_name NVARCHAR(50),
	@book_author_last_name NVARCHAR(50),
	@book_genre NVARCHAR(50)
AS
BEGIN
	UPDATE Books 
	SET book_name = @book_name,		
		book_publication_date = @book_publication_date,
		book_price = @book_price,
		book_quantity = @book_quantity	
	WHERE book_id = @book_id;
	DECLARE @book_author_id INT;
	DECLARE @book_genre_id INT;
	SET @book_author_id = (SELECT author_id FROM Authors 
									WHERE author_first_name = @book_author_first_name AND author_last_name = @book_author_last_name);
	SET @book_genre_id = (SELECT genre_id FROM Genres 
									WHERE genre_name = @book_genre);
		UPDATE Books_authors 
		SET book_author_id = @book_author_id
		WHERE book_id = @book_id;		
		UPDATE Books_genres 
		SET book_genre_id = @book_genre_id
		WHERE book_id = @book_id;	
	SELECT * FROM Books 
		WHERE book_id = @book_id;
END;

GO
CREATE PROCEDURE UpdateStudent
	@student_id INT,
	@student_first_name NVARCHAR(50),	
	@student_last_name NVARCHAR(50),	
	@student_number INT,	
	@student_faculty NVARCHAR(10),
	@student_semester INT,
	@student_contact NVARCHAR(15),
	@student_email NVARCHAR(50)
AS
BEGIN
	UPDATE Students 
	SET student_first_name = @student_first_name,		
		student_last_name = @student_last_name,
		student_number = @student_number,
		student_faculty = @student_faculty,
		student_semester = @student_semester,
		student_contact = @student_contact,
		student_email = @student_email
	WHERE student_id = @student_id;	
	SELECT * FROM Students 
		WHERE student_number = @student_number;
END;

--DELETE PROCEDURES--
GO
CREATE PROCEDURE DeleteBook
	@book_id INT	
AS
BEGIN
	SELECT * FROM Books	
			WHERE book_id = @book_id;
	DELETE FROM Books_authors
		WHERE book_id = @book_id;	
	DELETE FROM Books_genres
		WHERE book_id = @book_id;	
	DELETE FROM Books	
		WHERE book_id = @book_id;	
END;

GO
CREATE PROCEDURE DeleteAuthor
	@author_id INT	
AS
BEGIN	
	SELECT * FROM Authors	
		WHERE author_id = @author_id;
	DELETE FROM Authors	
		WHERE author_id = @author_id;	
END;

GO
CREATE PROCEDURE DeleteGenre
	@genre_id INT	
AS
BEGIN
	SELECT * FROM Genres	
		WHERE genre_id = @genre_id;
	DELETE FROM Genres	
		WHERE genre_id = @genre_id;	
END;

GO
CREATE PROCEDURE DeleteStudent
	@student_id INT	
AS
BEGIN	
	SELECT * FROM Students	
		WHERE student_id = @student_id;
	DELETE FROM Students	
		WHERE student_id = @student_id;	
END;

--REGISTRATION PROCEDURE--
GO
CREATE PROCEDURE RegisterStudent  		
	@student_number INT,
	@student_registered_date DATETIME = NULL,
	@student_blocked_date DATETIME = NULL,
	@student_status NVARCHAR(10) = 'Blocked'
AS
BEGIN	
	UPDATE Students 
		SET student_registered_date = SYSDATETIME(),
			student_status = 'Registered',
			student_blocked_date = NULL
				WHERE student_number = @student_number;
	SELECT * FROM Students 
		WHERE student_number = @student_number;
END;

--BLOCK PROCEDURE--
GO
CREATE PROCEDURE BlockStudent  		
	@student_number INT,
	@student_registered_date DATETIME = NULL,
	@student_blocked_date DATETIME = NULL,
	@student_status NVARCHAR(10) = 'Registered'
AS
BEGIN	
	UPDATE Students 
		SET student_blocked_date = SYSDATETIME(),
			student_status = 'Blocked'
				WHERE student_number = @student_number;
	SELECT * FROM Students 
		WHERE student_number = @student_number;
END;

--HISTORY PROCEDURES--
GO
CREATE PROCEDURE GetBooksHistory AS
BEGIN	
	SELECT * FROM BooksHistory;
END;

GO
CREATE PROCEDURE GetAuthorsHistory AS
BEGIN	
	SELECT * FROM AuthorsHistory;
END;

GO
CREATE PROCEDURE GetGenresHistory AS
BEGIN	
	SELECT * FROM GenresHistory;
END;

GO
CREATE PROCEDURE GetStudentsHistory AS
BEGIN	
	SELECT * FROM StudentsHistory;
END;

--FUNCTIONS--
GO
CREATE FUNCTION CountBooksByAuthor(@author_last_name NVARCHAR(50))
    RETURNS INT
BEGIN      	          	
	RETURN (SELECT  COUNT(*) FROM Authors AS A
				INNER JOIN Books_authors AS B_a
					ON A.author_id = B_a.book_author_id
				INNER JOIN Books AS B
					ON B_a.book_id = B.book_id
						WHERE A.author_last_name = @author_last_name);
END;	

GO
CREATE PROCEDURE GetCountBooksByAuthors AS
BEGIN	
	SELECT Authors.author_first_name AS FirstName, Authors.author_last_name AS LastName,
		dbo.CountBooksByAuthor(author_last_name)[BooksCount] FROM Authors;
END;

GO
CREATE FUNCTION GetOrdersForStudent (
	@student_number NVARCHAR(20)
)
RETURNS TABLE
AS
RETURN
   SELECT student_id, ordered_book_name, student_number, COUNT(ordered_book_id) AS number_of_orders, SUM(ordered_book_quantity) AS ordered_books_quantity
		FROM Orders		
			WHERE student_number = @student_number
				GROUP BY student_id, student_number, ordered_book_name;

--IMPORT PROCEDURE--
CREATE PROCEDURE ImportStudents AS
BEGIN
INSERT INTO Students
SELECT
A.student.query('student_first_name').value('.','NVARCHAR(50)') AS student_first_name,
A.student.query('student_last_name').value('.','NVARCHAR(50)') AS student_last_name,
A.student.query('student_number').value('.','INT') AS student_number,
A.student.query('student_faculty').value('.','NVARCHAR(10)') AS student_faculty,
A.student.query('student_semester').value('.','INT') AS student_semester,
A.student.query('student_contact').value('.','NVARCHAR(15)') AS student_contact,
A.student.query('student_email').value('.','NVARCHAR(50)') AS student_email,
CONVERT(DATETIME, NULLIF(A.student.query('student_registered_date').value('.' ,'DATETIME'),'')) AS student_registered_date,
CONVERT(DATETIME, NULLIF(A.student.query('student_blocked_date').value('.' ,'DATETIME'),'')) AS student_blocked_date,
A.student.query('student_status').value('.','NVARCHAR(10)') AS student_status
FROM
(
SELECT CAST(s AS XML) FROM
OPENROWSET (BULK 'D:\3course\LibraryManagementSystem\xml\students_import.xml', SINGLE_BLOB) AS T(s)
) AS S(s)
cross apply s.nodes('students/student') as A(student)
SELECT * FROM Students;
END;

--EXPORT PROCEDURE--
CREATE PROCEDURE ExportStudents
AS
BEGIN
EXEC master.dbo.sp_configure 'show advanced options', 1
RECONFIGURE WITH OVERRIDE;
EXEC master .dbo.sp_configure 'xp_cmdshell', 1
RECONFIGURE WITH OVERRIDE;
DECLARE @fileName NVARCHAR(100);
DECLARE @sqlStr NVARCHAR(1000);
DECLARE @sqlCmd NVARCHAR(1000);
SET @fileName = 'D:\3course\LibraryManagementSystem\xml\students_export.xml';
SET @sqlStr = 'USE LIBRARY; SELECT * FROM dbo.Students FOR XML PATH(''student''), ROOT(''students'')'
SET @sqlCmd = 'bcp.exe "' + @sqlStr + '" queryout ' + @fileName + ' -w -T -S "DESKTOP-ANFNK89"'
EXEC xp_cmdshell @sqlCmd;
END;

--ORDER PROCEDURE--
GO
CREATE PROCEDURE OrderBook  		
	@book_name NVARCHAR(50),
	@student_number INT,
	@quantity INT,
	@order_date DATE	
AS
BEGIN	
	DECLARE 
		@ErrorMessage  NVARCHAR(100), 
		@ErrorSeverity INT, 
		@ErrorState    INT;
	BEGIN TRY
		DECLARE @book_id INT;
		DECLARE @student_id INT;
		DECLARE @books_quantity INT;
		DECLARE @difference INT;
		DECLARE @student_status NVARCHAR(10);
		SET @book_id = (SELECT book_id FROM Books 
								WHERE book_name = @book_name);
		SET @student_id = (SELECT student_id FROM Students 
								WHERE student_number = @student_number);
		SET @books_quantity = (SELECT book_quantity	FROM Books		
					WHERE book_id = @book_id);
		SET @student_status = (SELECT student_status FROM Students 
									WHERE student_id = @student_id);
		SET @difference = @books_quantity - @quantity;	
		IF(@books_quantity = 0)									
			RAISERROR('There is no such book now!', 16, 1);	
		IF(@student_status = 'Blocked')
			RAISERROR('You are not registred!', 16, 1);	
		IF(@difference < 0)
			RAISERROR('There are not that many books in the library! Try less!', 16, 1);			
		ELSE
			BEGIN
			INSERT INTO Orders VALUES (@book_id, @student_id, @student_number, @book_name, @quantity, @order_date);
				UPDATE Books	
					SET book_quantity -= @quantity			
							WHERE book_id = @book_id;				
			END;
	END TRY
	BEGIN CATCH
		SELECT 
			@ErrorMessage = ERROR_MESSAGE(), 
			@ErrorSeverity = ERROR_SEVERITY(), 
			@ErrorState = ERROR_STATE();		
		RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
	SELECT * FROM Orders;
END;

--RETURN PROCEDURE--
GO
CREATE PROCEDURE ReturnBook  		
	@book_name NVARCHAR(50),
	@student_number INT,
	@quantity INT	
AS
BEGIN	
DECLARE 
		@ErrorMessage  NVARCHAR(100), 
		@ErrorSeverity INT, 
		@ErrorState    INT;
	BEGIN TRY
		DECLARE @book_id INT;
		DECLARE @student_id INT;
		DECLARE @books_quantity INT;
		DECLARE @return_date DATE			
		DECLARE @total_ordered_book_quantity INT;
		SET @book_id = (SELECT TOP(1) ordered_book_id FROM Orders
									WHERE ordered_book_name = @book_name);
		SET @student_id = (SELECT TOP(1) student_id FROM Orders
									WHERE student_number = @student_number);
		SET @books_quantity = (SELECT ordered_books_quantity FROM dbo.GetOrdersForStudent(@student_number)
									WHERE ordered_book_name = @book_name);			
		SET @return_date = (SELECT CAST(GETDATE() AS DATE));	
		SET @total_ordered_book_quantity = (SELECT SUM(ordered_book_quantity) AS TotalOrderedBooks
													FROM Orders
														WHERE ordered_book_name = @book_name AND student_number = @student_number
															GROUP BY student_id, ordered_book_name);		
		IF((SELECT SUM(returned_book_quantity) AS TotalReturnedBooks
													FROM ReturnOrders
														WHERE ordered_book_name = @book_name AND student_number = @student_number
															GROUP BY student_id, ordered_book_name) = @total_ordered_book_quantity)																			
				RAISERROR('You returned all the books!', 16, 1);	
		IF(@quantity > ((SELECT MAX(total_ordered_book_quantity) FROM ReturnOrders WHERE ordered_book_name = @book_name AND student_number = @student_number)-(SELECT MAX(returned_book_quantity) FROM ReturnOrders WHERE ordered_book_name = @book_name AND student_number = @student_number)))
				RAISERROR('You dont have that many books! Try less!', 16, 1);	
		ELSE
		--total_ordered_book_quantity drop procedure ReturnBook
			BEGIN
				INSERT INTO ReturnOrders VALUES (@book_id, @student_id, @student_number, @book_name, @books_quantity, @quantity, @return_date)			
					UPDATE Books	
						SET book_quantity += @quantity			
							WHERE book_id = @book_id;
			END;
		END TRY
		BEGIN CATCH
			SELECT 
				@ErrorMessage = ERROR_MESSAGE(), 
				@ErrorSeverity = ERROR_SEVERITY(), 
				@ErrorState = ERROR_STATE();		
			RAISERROR(@ErrorMessage, @ErrorSeverity, @ErrorState);
		END CATCH
		SELECT * FROM ReturnOrders;
END;

GO
CREATE PROCEDURE GetOrdersByStudent 
	@student_number INT
AS
BEGIN	
	SELECT * FROM dbo.GetOrdersForStudent(@student_number);		
END;


GO
CREATE PROCEDURE InsertBooks 	
AS
BEGIN	
DECLARE @i INT;
SET @i = 50001;
WHILE @i<=100000
	BEGIN		
	DECLARE @bookName NVARCHAR(50);
	SET @bookName = 'TestBookName' + CAST(@i AS NVARCHAR(6));
	EXECUTE AddBook @bookName, '2021-12-19', 10, 5, 'TestFirstName3', 'TestLastName3', 'TestGenre3';
	SET @i = @i + 1;
	END;
END;

EXECUTE InsertBooks;

drop procedure InsertBooks;
select count(*) from Books;


