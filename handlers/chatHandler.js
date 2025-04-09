// handlers/chatHandler.js
module.exports = (io, socket) => {
  const acesso = socket.handshake.query.acesso;
  
  socket.join(`acesso_${acesso}`);

  const enviarMensagem = (payload) => {
    try {
      io.to(`acesso_${acesso}`).emit("chat:receber", {
        ...payload,
        dDataEnvio: new Date() 
      });
      
    } catch (error) {
      console.error('Erro ao enviar mensagem:', error);
    }
  }

  socket.on("chat:enviar", enviarMensagem);
} 