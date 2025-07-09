const conn = require("../db/conn");
const jwt = require("jsonwebtoken");

const salvarMensagem = async (req, res) => {
  try {
    const {
      sNomeUsuario,
      sMensagem,
      nCodigoEmpresa,
      nAcesso,
      nCodigoParceiroNegocio,
    } = req.body;

    const sql = `CALL sp_insert_chat_mensagem_remetente(:p_codigo_empresa, 
                                                        :p_acesso, 
                                                        :p_mensagem, 
                                                        :p_nome_usuario.
                                                        :p_codigo_parceiro_negocio
                                                        )`;

    await conn.query(sql, {
      replacements: {
        p_codigo_empresa: nCodigoEmpresa,
        p_acesso: nAcesso,
        p_mensagem: sMensagem,
        p_nome_usuario: sNomeUsuario,
        p_codigo_parceiro_negocio: nCodigoParceiroNegocio,
      },
    });
  } catch (err) {
    console.error("Erro ao salvar mensagem:", err);
    res.status(500).json({ error: "Erro ao salvar mensagem." });
  }
};

const novoAcesso = async (req, res) => {
  try {

    const {
      sDescricao,
    } = req.body;

    const sql = `CALL sp_chat_novo_suporte(:p_codigo_empresa, :p_codigo_usuario, :p_assunto)`;

    const [result] = await conn.query(sql, {
      replacements: {
        p_codigo_empresa: req.jwtInfo.jwt_nCodigoEmpresa,
        p_codigo_usuario: req.jwtInfo.jwt_nCodigoUsuario,
        p_assunto: sDescricao
      },
    });

    res.status(200).json(result);
  } catch (err) {
    console.error("Erro ao iniciar sessão:", err);
    res.status(500).json({ error: "Erro ao iniciar sessão." });
  }
};

const loadInicial = async (req, res) => {
  try {

    const {
      nCodigoChat,
      nCodigoEmpresa
    } = req.body;

    const execQuery = `call sp_select_chat_sessao_mensagem(:p_codigo_chat,
                                                           :p_codigo_empresa
                                                           )`;

    const results = await conn.query(execQuery, {
      replacements: {
        p_codigo_empresa: nCodigoEmpresa,
        p_codigo_chat: nCodigoChat, 
      },
    });

    res.status(200).json(results);
  } catch (err) {
    console.error('Erro no carregamento inicial:', err);
    res.status(500).json({ error: 'Erro no carregamento inicial.' });
  }
};

module.exports = {
  salvarMensagem,
  novoAcesso,
  loadInicial
};
