const express = require('express');
const validaToken = require ('../utils/validaToken.js')
const {  
    salvarMensagem,
    novoAcesso
} = require('../controllers/chatController');

const router = express.Router();

router.post('/salvarmensagem', salvarMensagem)
router.post('/acesso', validaToken, novoAcesso)

module.exports = router; 