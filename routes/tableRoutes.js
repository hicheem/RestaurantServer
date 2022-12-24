const { Router } = require('express');
const express = require('express');
const { bookTable, modifyStatusTable, getTables } = require('../controllers/tableController');

const router = express.Router()

router.get('/bookTable', bookTable)
router.put('/statusTable', modifyStatusTable)
router.get('/getTables', getTables)


module.exports = router