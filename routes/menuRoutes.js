const { Router } = require('express');
const express = require('express');
const auth = require('../Authorization/authorization');
const { getMenusWithItem, getMenus, updateMenu, addMenu, deleteMenu, getItemsAdmin } = require('../controllers/menuController');

const router = express.Router()

router.get('/menusWithItems', getMenusWithItem)
router.get('/getMenus', getMenus)
router.get('/getItemsAdmin', getItemsAdmin)

router.put('/updateMenu', auth,  updateMenu)
router.post('/addMenu', auth,  addMenu)
router.delete('/deleteMenu', auth,  deleteMenu)


module.exports = router