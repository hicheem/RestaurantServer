const { Router } = require('express');
const express = require('express');
const { addOrder, addOrderItem } = require('../controllers/orderController');

const router = express.Router()

router.post('/addOrder', addOrder)
router.post('/addOrderItem', addOrderItem)


module.exports = router