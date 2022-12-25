const { Router } = require('express');
const express = require('express');
const auth = require('../Authorization/authorization');
const { addBook, addBookItem, getBooking, getAllBooking, getBookingDetails, updateBookStatus } = require('../controllers/bookController');

const router = express.Router()

router.post('/addBook', addBook)
router.post('/addBookItem', addBookItem)
router.get('/getBooking', getBooking)
router.get('/getAllBooking', getAllBooking)
router.get('/getBookingDetails', getBookingDetails)
router.put('/updateBookStatus', auth, updateBookStatus)



module.exports = router