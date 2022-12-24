const { Router } = require('express');
const express = require('express');
const { loginUser, getUsers, addUser, updateUser } = require('../controllers/userController');
const auth = require('../Authorization/authorization');


const router = express.Router()

router.get('/login', loginUser)
router.get('/users', getUsers)

router.post('/addUser', auth, addUser)
router.post('/updateUser', updateUser)


module.exports = router