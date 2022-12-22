const { Router } = require('express');
const express = require('express');
const { addBook, addBookItem } = require('../controllers/bookController');

const router = express.Router()

router.post('/addBook', addBook)
router.post('/addBookItem', addBookItem)


module.exports = router