const { Router } = require('express');
const express = require('express');
const { addBook, addBookItem, getBooking, getAllBooking } = require('../controllers/bookController');

const router = express.Router()

router.post('/addBook', addBook)
router.post('/addBookItem', addBookItem)
router.get('/getBooking', getBooking)
router.get('/getAllBooking', getAllBooking)


module.exports = router