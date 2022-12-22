const { Router } = require('express');
const express = require('express');
const { addBook, addBookItem, getBooking } = require('../controllers/bookController');

const router = express.Router()

router.post('/addBook', addBook)
router.post('/addBookItem', addBookItem)
router.get('/getBooking', getBooking)


module.exports = router