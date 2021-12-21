'use strict';

const eventData = require('../data/events');

const GetBooks = async (req, res) => {
  try {
    const books = await eventData.GetBooks();
    res.json(books);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetAuthors = async (req, res) => {
  try {
    const authors = await eventData.GetAuthors();
    res.json(authors);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetGenres = async (req, res) => {
  try {
    const genres = await eventData.GetGenres();
    res.json(genres);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetStudents = async (req, res) => {
  try {
    const students = await eventData.GetStudents();
    res.json(students);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetOrders = async (req, res) => {
  try {
    const orders = await eventData.GetOrders();
    res.json(orders);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetReturns = async (req, res) => {
  try {
    const returns = await eventData.GetReturns();
    res.json(returns);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetBookById = async (req, res) => {
  try {
    const bookId = req.params.id;
    const oneBook = await eventData.GetBookById(bookId);
    res.json(oneBook);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetBookByName = async (req, res) => {
  try {
    const bookName = req.params.name;
    const oneBook = await eventData.GetBookByName(bookName);
    res.json(oneBook);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetBooksByAuthor = async (req, res) => {
  try {
    const bookAuthor = req.params.author;
    const books = await eventData.GetBooksByAuthor(bookAuthor);
    res.json(books);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetBooksByGenre = async (req, res) => {
  try {
    const bookGenre = req.params.genre;
    const books = await eventData.GetBooksByGenre(bookGenre);
    res.json(books);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetStudentByNumber = async (req, res) => {
  try {
    const studentNumber = req.params.number;
    const oneStudent = await eventData.GetStudentByNumber(studentNumber);
    res.json(oneStudent);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const AddBook = async (req, res) => {
  try {
    const data = req.body;
    const newBook = await eventData.AddBook(data);
    res.json(newBook);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const AddAuthor = async (req, res) => {
  try {
    const data = req.body;
    const newAuthor = await eventData.AddAuthor(data);
    res.json(newAuthor);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const AddGenre = async (req, res) => {
  try {
    const data = req.body;
    const newGenre = await eventData.AddGenre(data);
    res.json(newGenre);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const AddStudent = async (req, res) => {
  try {
    const data = req.body;
    const newStudent = await eventData.AddStudent(data);
    res.json(newStudent);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const UpdateBook = async (req, res) => {
  try {
    const bookId = req.params.id;
    const data = req.body;
    const updatedBook = await eventData.UpdateBook(bookId, data);
    res.json(updatedBook);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const UpdateStudent = async (req, res) => {
  try {
    const studentId = req.params.id;
    const data = req.body;
    const updatedStudent= await eventData.UpdateStudent(studentId, data);
    res.json(updatedStudent);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const DeleteBook = async (req, res) => {
  try {
    const bookId = req.params.id;
    const deletedBook = await eventData.DeleteBook(bookId);
    res.json(deletedBook);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const DeleteAuthor = async (req, res) => {
  try {
    const authorId = req.params.id;
    const deletedAuthor = await eventData.DeleteAuthor(authorId);
    res.json(deletedAuthor);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const DeleteGenre = async (req, res) => {
   try {
     const genreId = req.params.id;
     const deletedGenre = await eventData.DeleteGenre(genreId);
     res.json(deletedGenre);
   } catch (error) {
     res.status(400).send(error.message);
   }
}

const DeleteStudent = async (req, res) => {
   try {
     const studentId = req.params.id;
     const deletedStudent = await eventData.DeleteStudent(studentId);
     res.json(deletedStudent);
   } catch (error) {
     res.status(400).send(error.message);
   }
}

const RegisterStudent = async (req, res) => {
  try {
    const studentNumber = req.params.number;
    const data = req.body;
    const registeredStudent= await eventData.RegisterStudent(studentNumber, data);
    res.json(registeredStudent);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const BlockStudent = async (req, res) => {
  try {
    const studentNumber = req.params.number;
    const data = req.body;
    const blockedStudent= await eventData.BlockStudent(studentNumber, data);
    res.json(blockedStudent);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetBooksHistory = async (req, res) => {
  try {
    const books = await eventData.GetBooksHistory();
    res.json(books);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetAuthorsHistory = async (req, res) => {
  try {
    const authors = await eventData.GetAuthorsHistory();
    res.json(authors);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetGenresHistory = async (req, res) => {
  try {
    const genres = await eventData.GetGenresHistory();
    res.json(genres);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetStudentsHistory = async (req, res) => {
  try {
    const students = await eventData.GetStudentsHistory();
    res.json(students);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const ImportStudents = async (req, res) => {
  try {
    const students = await eventData.ImportStudents();
    res.json(students);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const ExportStudents = async (req, res) => {
  try {
    const students = await eventData.ExportStudents();
    res.end("Students exported!");
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetCountBooksByAuthors = async (req, res) => {
  try {
    const countBooks = await eventData.GetCountBooksByAuthors();
    res.json(countBooks);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const OrderBook = async (req, res) => {
  try {
    const bookName = req.params.name;
    const data = req.body;
    const orders = await eventData.OrderBook(bookName, data);
    res.json(orders);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const ReturnBook = async (req, res) => {
  try {
    const bookName = req.params.name;
    const data = req.body;
    const return_order = await eventData.ReturnBook(bookName, data);
    res.json(return_order);
  } catch (error) {
    res.status(400).send(error.message);
  }
}

const GetOrdersByStudent = async (req, res) => {
  try {
    const studentNumber = req.params.number;
    const orders = await eventData.GetOrdersByStudent(studentNumber);
    res.json(orders);
  } catch (error) {
    res.status(400).send(error.message);
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