// handlers/chatHandler.js
module.exports = (io, socket) => {
    // Extrai o acesso da query de conexão
    const acesso = socket.handshake.query.acesso;
    
    // Entra na sala específica para este acesso
    socket.join(`acesso_${acesso}`);
  
    // Handler para envio de mensagens
    const enviarMensagem = (payload) => {
      try {
        // Envia apenas para a sala do acesso específico
        io.to(`acesso_${acesso}`).emit("chat:receber", {
          ...payload,
          dDataEnvio: new Date() // Data do servidor
        });
        
      } catch (error) {
        console.error('Erro ao enviar mensagem:', error);
      }
    }
  
    socket.on("chat:enviar", enviarMensagem);
  }