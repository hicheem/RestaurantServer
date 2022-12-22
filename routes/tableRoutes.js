const { Router } = require('express');
const express = require('express');
const { getTable, modifyStatusTable } = require('../controllers/tableController');

const router = express.Router()

router.get('/getTable', getTable)
router.put('/statusTable', modifyStatusTable)


module.exports = router