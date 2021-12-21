'use strict';

const express = require('express');
const eventController = require('../controllers/eventController')
const router = express.Router();

const {
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
} = eventController;

router.get('/books', GetBooks);
router.get('/authors', GetAuthors);
router.get('/genres', GetGenres);
router.get('/students', GetStudents);
router.get('/orders', GetOrders);
router.get('/returns', GetReturns);
router.get('/book/id/:id', GetBookById);
router.get('/book/name/:name', GetBookByName);
router.get('/books/author/:author', GetBooksByAuthor);
router.get('/books/genre/:genre', GetBooksByGenre);
router.get('/students/number/:number', GetStudentByNumber);

router.get('/books/history', GetBooksHistory);
router.get('/authors/history', GetAuthorsHistory);
router.get('/genres/history', GetGenresHistory);
router.get('/students/history', GetStudentsHistory);

router.get('/books/countbyauthors', GetCountBooksByAuthors);

router.post('/add/book', AddBook);
router.post('/add/author', AddAuthor);
router.post('/add/genre', AddGenre);
router.post('/add/student', AddStudent);

router.post('/import/students', ImportStudents);
router.post('/export/students', ExportStudents);

router.put('/update/book/:id', UpdateBook);
router.put('/update/student/:id', UpdateStudent);

router.put('/register/student/number/:number', RegisterStudent);
router.put('/block/student/number/:number', BlockStudent);

router.put('/order/book/:name', OrderBook);
router.put('/return/book/:name', ReturnBook);

router.get('/orders/student/:number', GetOrdersByStudent);

router.delete('/delete/book/:id', DeleteBook);
router.delete('/delete/author/:id', DeleteAuthor);
router.delete('/delete/genre/:id', DeleteGenre);
router.delete('/delete/student/:id', DeleteStudent);

module.exports = {
  routes: router
}