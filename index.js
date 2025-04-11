const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const conn = require('./db/conn');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');
const { Server } = require('socket.io');


const app = express();
const server = http.createServer(app);
dotenv.config();

app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));

const io = new Server(server, {
  cors: {
    origin: '*',
  },
  path: "/socket.io/"
});

const ChatRoutes = require ('./routes/ChatRoute.js');
const loginSignupRoutes = require('./routes/loginSignUpRoute');
const hubRoutes = require('./routes/hubRoute.js');

const chatNamespace = io.of('/chat');
const chatHandler = require('./handlers/chatHandler');
const { validaTokenSocket } = require('./utils/validaTokenSocket.js');

chatNamespace.use(validaTokenSocket);
chatNamespace.on('connection', (socket) => {
  console.log(`Novo cliente autenticado: ${socket.jwtInfo.jwt_nCodigoUsuario}`);
  chatHandler(chatNamespace, socket);
});

app.use('/chat', ChatRoutes)
app.use('/loginsignup', loginSignupRoutes);
app.use('/hub', hubRoutes);

server.listen(3000, () => {
  console.log('Servidor HTTP e WebSocket rodando na porta 3000');
});