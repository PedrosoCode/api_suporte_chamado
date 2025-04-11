const conn = require("../db/conn");
const jwt = require("jsonwebtoken");

const loadSuportes = async (req, res) => {
  try {

    const execQuery = `call sp_select_pool_chamados()`;

    const results = await conn.query(execQuery);

    res.status(200).json(results);
  } catch (err) {
    console.error("Erro no carregamento inicial:", err);
    res.status(500).json({ error: "Erro no carregamento inicial." });
  }
};

module.exports = {
  loadSuportes,
};
