const conn = require('../db/conn');
const jwt = require('jsonwebtoken')

module.exports = (io, socket) => {
  const acesso = socket.handshake.query.acesso;
  const empresa_chat = socket.handshake.query.empresa_chat;

  socket.join(`acesso_${acesso}_empresa_${empresa_chat}`);

  const enviarMensagem = async (payload) => {
    try {
      io.to(`acesso_${acesso}_empresa_${empresa_chat}`).emit("chat:receber", {
        ...payload,
        dDataEnvio: new Date(),
      });

      const sql = `CALL sp_insert_chat_sessao_mensagem(
        :p_codigo_chat,
        :p_codigo_empresa_chat,
        :p_codigo_empresa_remetente,
        :p_codigo_remetente,
        :p_texto_mensagem
      )`;
      
      await conn.query(sql, {
        replacements: {
          p_codigo_chat: payload.nCodigoChat, 
          p_codigo_empresa_chat: payload.nCodigoEmpresaChat,
          p_codigo_empresa_remetente: payload.nCodigoEmpresaRemetente,
          p_codigo_remetente: payload.nRemetente,
          p_texto_mensagem: payload.sTexto, 
        },
      });

    } catch (error) {
      console.error("Erro ao salvar mensagem:", error);
      socket.emit("chat:erro", "Falha ao enviar mensagem");
    }
  };

  socket.on("chat:enviar", enviarMensagem);
};