const express = require('express');
const validaToken = require ('../utils/validaToken.js')

const {
    loadSuportes
} = require('../controllers/hubController');

const router = express.Router();

router.post('/listagem', validaToken, loadSuportes)

module.exports = router; 