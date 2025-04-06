const conn = require("../db/conn");
const jwt = require("jsonwebtoken");

const validaToken = (req, res, next) => {
  const authHeader = req.headers["authorization"];
  if (!authHeader) {
    return res.status(401).json({ error: "Token não fornecido." });
  }

  const token = authHeader.split(" ")[1];
  if (!token) {
    return res.status(401).json({ error: "Token inválido." });
  }

  try {
    const jwtInfo = jwt.verify(token, process.env.JWT_SECRET);
    if (!jwtInfo || !jwtInfo.jwt_nCodigoEmpresa) {
      return res.status(403).json({ error: "Token inválido ou expirado." });
    }

    req.jwtInfo = jwtInfo; 
    next();
  } catch (error) {
    return res.status(403).json({ error: "Token inválido ou expirado." });
  }
};

module.exports = validaToken;
