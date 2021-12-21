'use strict';

const utils = require('../utils');
const config = require('../../config');
const sql = require('mssql');

const GetBooks = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetBooks);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetAuthors = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetAuthors);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetGenres = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetGenres);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetStudents = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetStudents);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetOrders = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetOrders);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetReturns = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetReturns);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetBookById = async (bookId) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const oneBook = await pool.request()
        .input('book_id', sql.Int, bookId)
        .query(sqlQueries.GetBookById);
    return oneBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetBookByName = async (bookName) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const oneBook = await pool.request()
        .input('book_name', sql.NVarChar(50), bookName)
        .query(sqlQueries.GetBookByName);
    return oneBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetBooksByAuthor = async (bookAuthor) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const books = await pool.request()
        .input('book_author_last_name', sql.NVarChar(50), bookAuthor)
        .query(sqlQueries.GetBooksByAuthor);
    return books.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetBooksByGenre = async (bookGenre) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const books = await pool.request()
        .input('book_genre', sql.NVarChar(50), bookGenre)
        .query(sqlQueries.GetBooksByGenre);
    return books.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetStudentByNumber = async (studentNumber) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const oneStudent = await pool.request()
        .input('student_number', sql.Int, studentNumber)
        .query(sqlQueries.GetStudentByNumber);
    return oneStudent.recordset;
  } catch (error) {
    return error.message;
  }
}

const AddBook = async (bookData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const newBook = await pool.request()
      .input('book_name', sql.NVarChar(50), bookData.book_name)
      .input('book_publication_date', sql.NVarChar(30), bookData.book_publication_date)
      .input('book_price', sql.Decimal(5,2), bookData.book_price)
      .input('book_quantity', sql.INT, bookData.book_quantity)
      .input('book_author_first_name', sql.NVarChar(50), bookData.book_author_first_name)
      .input('book_author_last_name', sql.NVarChar(50), bookData.book_author_last_name)
      .input('book_genre', sql.NVarChar(50), bookData.book_genre)
      .query(sqlQueries.AddBook);
    return newBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const AddAuthor = async (authorData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const newAuthor = await pool.request()
        .input('book_author_first_name', sql.NVarChar(50), authorData.book_author_first_name)
        .input('book_author_last_name', sql.NVarChar(50), authorData.book_author_last_name)
        .query(sqlQueries.AddAuthor);
    return newAuthor.recordset;
  } catch (error) {
    return error.message;
  }
}

const AddGenre = async (genreData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const newGenre = await pool.request()
        .input('book_genre', sql.NVarChar(50), genreData.book_genre)
        .query(sqlQueries.AddGenre);
    return newGenre.recordset;
  } catch (error) {
    return error.message;
  }
}

const AddStudent = async (studentData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const newStudent = await pool.request()
        .input('student_first_name', sql.NVarChar(50), studentData.student_first_name)
        .input('student_last_name', sql.NVarChar(50), studentData.student_last_name)
        .input('student_number', sql.Int, studentData.student_number)
        .input('student_faculty', sql.NVarChar(10), studentData.student_faculty)
        .input('student_semester', sql.Int, studentData.student_semester)
        .input('student_contact', sql.NVarChar(15), studentData.student_contact)
        .input('student_email', sql.NVarChar(50), studentData.student_email)
        .input('student_registered_date', sql.DateTime, null)
        .input('student_blocked_date', sql.DateTime, null)
        .input('student_status', sql.NVarChar(10), 'Blocked')
        .query(sqlQueries.AddStudent);
    return newStudent.recordset;
  } catch (error) {
    return error.message;
  }
}

const UpdateBook = async (bookId, bookData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const updatedBook = await pool.request()
        .input('book_id', sql.Int, bookId)
        .input('book_name', sql.NVarChar(50), bookData.book_name)
        .input('book_publication_date', sql.NVarChar(30), bookData.book_publication_date)
        .input('book_price', sql.Decimal(5,2), bookData.book_price)
        .input('book_quantity', sql.Int, bookData.book_quantity)
        .input('book_author_first_name', sql.NVarChar(50), bookData.book_author_first_name)
        .input('book_author_last_name', sql.NVarChar(50), bookData.book_author_last_name)
        .input('book_genre', sql.NVarChar(50), bookData.book_genre)
        .query(sqlQueries.UpdateBook);
    return updatedBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const UpdateStudent = async (studentId, studentData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const updatedStudent = await pool.request()
        .input('student_id', sql.Int, studentId)
        .input('student_first_name', sql.NVarChar(50), studentData.student_first_name)
        .input('student_last_name', sql.NVarChar(50), studentData.student_last_name)
        .input('student_number', sql.Int, studentData.student_number)
        .input('student_faculty', sql.NVarChar(10), studentData.student_faculty)
        .input('student_semester', sql.Int, studentData.student_semester)
        .input('student_contact', sql.NVarChar(15), studentData.student_contact)
        .input('student_email', sql.NVarChar(50), studentData.student_email)
        .query(sqlQueries.UpdateStudent);
    return updatedStudent.recordset;
  } catch (error) {
    return error.message;
  }
}

const DeleteBook = async (bookId) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const deletedBook = await pool.request()
        .input('book_id', sql.Int, bookId)
        .query(sqlQueries.DeleteBook);
    return deletedBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const DeleteAuthor = async (authorId) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const deletedAuthor = await pool.request()
        .input('author_id', sql.Int, authorId)
        .query(sqlQueries.DeleteAuthor);
    return deletedAuthor.recordset;
  } catch (error) {
    return error.message;
  }
}

const DeleteGenre = async (genreId) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const deletedGenre = await pool.request()
        .input('genre_id', sql.Int, genreId)
        .query(sqlQueries.DeleteGenre);
    return deletedGenre.recordset;
  } catch (error) {
    return error.message;
  }
}

const DeleteStudent = async (studentId) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const deletedStudent = await pool.request()
        .input('student_id', sql.Int, studentId)
        .query(sqlQueries.DeleteStudent);
    return deletedStudent.recordset;
  } catch (error) {
    return error.message;
  }
}

const RegisterStudent = async (studentNumber, studentData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const registeredStudent = await pool.request()
        .input('student_number', sql.Int, studentNumber)
        .input('student_registered_date', sql.DateTime, new Date())
        .input('student_blocked_date', sql.DateTime, null)
        .input('student_status', sql.NVarChar(10), 'Registered')
        .query(sqlQueries.RegisterStudent);
    return registeredStudent.recordset;
  } catch (error) {
    return error.message;
  }
}

const BlockStudent = async (studentNumber, studentData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const blockedStudent = await pool.request()
        .input('student_number', sql.Int, studentNumber)
        .input('student_registered_date', sql.DateTime, null)
        .input('student_blocked_date', sql.DateTime, new Date())
        .input('student_status', sql.NVarChar(10), 'Blocked')
        .query(sqlQueries.BlockStudent);
    return blockedStudent.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetBooksHistory = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetBooksHistory);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetAuthorsHistory = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetAuthorsHistory);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetGenresHistory = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetGenresHistory);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetStudentsHistory = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetStudentsHistory);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const ImportStudents = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.ImportStudents);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const ExportStudents = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.ExportStudents);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetCountBooksByAuthors = async () => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const list = await pool.request().query(sqlQueries.GetCountBooksByAuthors);
    return list.recordset;
  } catch (error) {
    return error.message;
  }
}

const OrderBook = async (bookName, orderData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const orderBook = await pool.request()
        .input('book_name', sql.NVarChar(50), bookName)
        .input('student_number', sql.Int, orderData.student_number)
        .input('quantity', sql.Int, orderData.quantity)
        .input('order_date', sql.Date, orderData.order_date)
        .query(sqlQueries.OrderBook);
    return orderBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const ReturnBook = async (bookName, returnData) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const returnBook = await pool.request()
        .input('book_name', sql.NVarChar(50), bookName)
        .input('student_number', sql.INT, returnData.student_number)
        .input('quantity', sql.Int, returnData.quantity)
        .query(sqlQueries.ReturnBook);
    return returnBook.recordset;
  } catch (error) {
    return error.message;
  }
}

const GetOrdersByStudent = async (studentNumber) => {
  try {
    let pool = await sql.connect(config.sql);
    const sqlQueries = await utils.loadSqlQueries('events');
    const orders = await pool.request()
        .input('student_number', sql.Int, studentNumber)
        .query(sqlQueries.GetOrdersByStudent);
    return orders.recordset;
  } catch (error) {
    return error.message;
  }
}

module.exports = {
  GetBooks,
  GetAuthors,
  GetGenres,
  GetStudents,
  GetOrders,
  GetReturns,
  GetBookById,
  GetBookByName,
  GetBooksByAuthor,
  GetBooksByGenre,
  GetStudentByNumber,
  AddBook,
  AddAuthor,
  AddGenre,
  AddStudent,
  UpdateBook,
  UpdateStudent,
  DeleteBook,
  DeleteAuthor,
  DeleteGenre,
  DeleteStudent,
  RegisterStudent,
  BlockStudent,
  GetBooksHistory,
  GetAuthorsHistory,
  GetGenresHistory,
  GetStudentsHistory,
  ImportStudents,
  ExportStudents,
  GetCountBooksByAuthors,
  OrderBook,
  ReturnBook,
  GetOrdersByStudent
}