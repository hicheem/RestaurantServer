const { Router } = require('express');
const express = require('express');
const auth = require('../Authorization/authorization');
const { addOrder, addOrderItem, getOrders, updateOrderOBStatus } = require('../controllers/orderController');

const router = express.Router()

router.post('/addOrder', addOrder)
router.post('/addOrderItem', addOrderItem)
router.get('/getOrders', getOrders)
router.put('/updateOrderOBStatus', auth, updateOrderOBStatus)

module.exports = router