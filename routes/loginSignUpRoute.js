const express = require('express');
const {
    getEmpresas,
    novo_usuario,
    login
} = require('../controllers/loginSignUpController');

const router = express.Router();

router.get('/combo/empresas', getEmpresas);
router.post('/cadastrar', novo_usuario);
router.post('/login', login);

module.exports = router;