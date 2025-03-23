const express = require('express');
const http = require('http');
const WebSocket = require('ws');
const conn = require('./db/conn');
const cors = require('cors');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const dotenv = require('dotenv');

const app = express();
const server = http.createServer(app);
const wss = new WebSocket.Server({ server }); // Nome correto da instância

dotenv.config();

// Configurações existentes
app.use(express.json());
app.use(cors());
app.use(express.urlencoded({ extended: false }));

// Mapa para armazenar conexões por acesso
const connections = new Map();

wss.on('connection', (ws, req) => { // Correto: wss.on('connection')
  // Extrair o acesso da URL
  const acesso = req.url.split('/')[2];
  
  if (!connections.has(acesso)) {
    connections.set(acesso, new Set());
  }
  const clientes = connections.get(acesso);
  clientes.add(ws);

  // Configurar handlers DENTRO da conexão
  ws.on('message', (message) => {
    const rawMessage = message.toString();
    
    try {
      const parsedMessage = JSON.parse(rawMessage);
      
      // Converter para Date antes de enviar
      const mensagemFormatada = {
        ...parsedMessage,
        dDataEnvio: new Date(parsedMessage.dDataEnvio)
      };
  
      clientes.forEach(client => {
        if (client !== ws && client.readyState === WebSocket.OPEN) {
          client.send(JSON.stringify(mensagemFormatada));
        }
      });
    } catch (error) {
      console.error('Mensagem inválida:', error);
    }
  });

  ws.on('close', () => {
    clientes.delete(ws);
    if (clientes.size === 0) {
      connections.delete(acesso);
    }
  });
});

// Mantenha suas rotas REST aqui...

// Iniciar servidor na porta correta
server.listen(3000, () => {
  console.log('Servidor HTTP e WebSocket rodando na porta 3000');
});