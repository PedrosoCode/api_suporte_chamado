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

module.exports = {
  salvarMensagem,
  novoAcesso,
};
