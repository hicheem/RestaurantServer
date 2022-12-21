const { Router } = require('express');
const express = require('express');
const { getMenus } = require('../controllers/menuController');

const router = express.Router()

router.get('/menus', getMenus)


module.exports = router