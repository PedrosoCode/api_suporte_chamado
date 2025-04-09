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

const io = new Server(server, {
  cors: {
    origin: '*',
  },
  path: "/socket.io/"
});

const ChatRoutes = require ('./routes/ChatRoute.js');
const loginSignupRoutes = require('./routes/loginSignUpRoute');

const chatNamespace = io.of('/chat');
const chatHandler = require('./handlers/chatHandler');

chatNamespace.on('connection', (socket) => {
  console.log(`Novo cliente no chat: ${socket.id}`);
  chatHandler(chatNamespace, socket); // Passa o namespace específico
});

// Configurações existentes
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));

app.use('/chat', ChatRoutes)
app.use('/loginsignup', loginSignupRoutes);

// const onConnection = (socket) => {
//   chatHandler(io, socket);
// }

// io.on("connection", onConnection);
  

// Iniciar servidor na porta correta
server.listen(3000, () => {
  console.log('Servidor HTTP e WebSocket rodando na porta 3000');
});