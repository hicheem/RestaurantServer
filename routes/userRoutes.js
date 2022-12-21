const { Router } = require('express');
const express = require('express');
const { loginUser } = require('../controllers/userController');

const router = express.Router()

router.get('/login', loginUser)


module.exports = router