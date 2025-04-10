const express = require('express');
const validaToken = require ('../utils/validaToken.js')
const {  
    salvarMensagem,
    novoAcesso,
    loadInicial
} = require('../controllers/chatController');

const router = express.Router();

router.post('/salvarmensagem', salvarMensagem)
router.post('/acesso', validaToken, novoAcesso)
router.post('/carregar', validaToken, loadInicial)

module.exports = router; 