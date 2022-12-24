const { Router } = require('express');
const express = require('express');
const auth = require('../Authorization/authorization');
const { getMenusWithItem, getMenus, updateMenu } = require('../controllers/menuController');

const router = express.Router()

router.get('/menusWithItems', getMenusWithItem)
router.get('/getMenus', getMenus)

router.post('/updateMenu', auth,  updateMenu)


module.exports = router