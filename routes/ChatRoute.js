const express = require('express');
const {  
    salvarMensagem
} = require('../controllers/chatController');

const router = express.Router();

router.post('/salvarmensagem', salvarMensagem)

module.exports = router; 